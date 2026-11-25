# -*- coding: utf-8 -*-
"""Assembles 8086 programs, runs them and compares the result with the expected output.

    python ci/run86.py                    # every ChapterNN/*.asm
    python ci/run86.py Chapter07          # only the given folders / files
    python ci/run86.py -v Chapter07/x.asm # also print the program's output

The assembler is UASM (MASM compatible; emu8086 syntax is very close to it). Its path is taken
from the UASM_BIN environment variable or from uasm / uasm64 on the PATH. Programs run under
unicorn in 8086 real mode; the DOS (INT 21h) and BIOS (INT 10h, 16h, 1Ah, 15h) services are
implemented here.

Directives in the source file (comment lines, anywhere in the file):

    ; INPUT: "12\\r"          keyboard input (C escapes: \\r Enter, \\x1b Esc, \\x08 backspace)
    ; PORT 125: 30 40 50      IN 125 reads these values in turn; the last value repeats
    ; REGISTERS: AX BX CF     print these registers and flags when the program ends
    ; MEMORY: result 4        print 4 bytes starting at the label 'result' when the program ends
    ; LIMIT: 200000           for endless loops: stopping after this many instructions is a pass
    ; RUN: compile only

The expected output is at the end of the file:

    ; Expected output:
    ; Hello World!
    ; AX=0005

The output is the screen at the end of the program (80 columns; trailing spaces on a line are
dropped), followed by what was written to ports ("OUT 4 <- 0249h") and the REGISTERS / MEMORY lines.
"""
import ast, ctypes, glob, os, re, shutil, subprocess, sys, tempfile

from unicorn import Uc, UcError, UC_ARCH_X86, UC_MODE_16, UC_HOOK_INTR, UC_HOOK_INSN, UC_HOOK_CODE, UC_PROT_ALL
from unicorn.x86_const import *

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
INC = os.path.join(REPO, 'inc')
PSP = 0x0700                  # the program's PSP segment
BIOS = 0xF000                 # segment of the default interrupt routines (F000:n*4)
CHUNK = 20000
DEFAULT_LIMIT = 5_000_000
COLS = 80

FLAGS = {'CF': 0, 'PF': 2, 'AF': 4, 'ZF': 6, 'SF': 7, 'TF': 8, 'IF': 9, 'DF': 10, 'OF': 11}
REGS = {n: getattr(sys.modules['unicorn.x86_const'], 'UC_X86_REG_' + n) for n in
        'AX BX CX DX SI DI BP SP CS DS ES SS IP AL AH BL BH CL CH DL DH'.split()}


class Stop(Exception):
    pass


# ---------------------------------------------------------------- assembling

def find_uasm():
    for c in (os.environ.get('UASM_BIN'), shutil.which('uasm'), shutil.which('uasm64'),
              r'C:\Users\Sercan\tools\uasm\uasm64.exe'):
        if c and os.path.exists(c):
            return c
    sys.exit('UASM not found (UASM_BIN environment variable or PATH)')


def prepare(src):
    """Turns an emu8086 source into a form UASM accepts; the original file is not touched."""
    lines = []
    for l in src.split('\n'):
        s = l.strip().lower()
        # emu8086 directives: #make_COM#, #start=robot.exe#, name "title"
        if re.match(r'#[\w.=-]+#', s) or re.match(r'name\s+["\']', s):
            lines.append('; ' + l)
            continue
        m = re.match(r'(\s*)include\s+[\'"]?([\w.]+)[\'"]?\s*(;.*)?$', l, re.I)
        if m:
            lines.append('%sinclude %s' % (m.group(1), m.group(2)))
            continue
        # emu8086 encodes LEA reg, variable as MOV reg, OFFSET variable in 3 bytes;
        # UASM picks the 4-byte 8D form and every later address shifts.
        m = re.match(r'(?i)(\s*(?:[\w@$?]+:\s*)?)LEA(\s+)(AX|BX|CX|DX|SI|DI|BP|SP)(\s*,\s*)([^;\[\]]+?)(\s*;.*)?$', l)
        if m and not re.search(r'(?i)\b(AX|BX|CX|DX|SI|DI|BP|SP)\b', m.group(5)):
            l = '%sMOV%s%s%sOFFSET %s%s' % (m.group(1), m.group(2), m.group(3), m.group(4), m.group(5), m.group(6) or '')
        # emu8086 abbreviations: b.[SI] = BYTE PTR [SI], w.[SI] = WORD PTR [SI]
        l = re.sub(r'(?i)\bb\.\[', 'BYTE PTR [', l)
        l = re.sub(r'(?i)\bw\.\[', 'WORD PTR [', l)
        # emu8086 allows underscores in binary numbers: 0000_0011b
        code, sep, comment = l.partition(';')
        code = re.sub(r'\b([01][01_]*[01])b\b', lambda m: m.group(1).replace('_', '') + 'b', code)
        l = code + sep + comment
        lines.append(l)
    body = '\n'.join(lines)
    exe = bool(re.search(r'^\s*\.model\s+(small|medium|compact|large)', body, re.I | re.M))
    if not re.search(r'^\s*\.model', body, re.I | re.M):
        body = '.8086\n.model tiny\n.code\n' + body
    elif not re.search(r'^\s*\.(8086|186|286)', body, re.I | re.M):
        body = '.8086\n' + body
    if not re.search(r'^\s*end\b', body, re.I | re.M):
        body += '\nend\n'
    return body, exe


def assemble(path, tmp):
    src = open(path, encoding='utf-8').read()
    body, exe = prepare(src)
    base = os.path.join(tmp, re.sub(r'\W', '_', os.path.relpath(path, REPO)))
    asm, out, lst = base + '.asm', base + ('.exe' if exe else '.com'), base + '.lst'
    open(asm, 'w', encoding='latin-1', errors='replace').write(body)
    # Label addresses are only needed for the MEMORY directive and are read from the listing file.
    # The Linux build of UASM 2.57 crashes while writing the listing of some files
    # ("buffer overflow detected"); in that case it is retried without a listing.
    want_list = bool(re.search(r'^\s*;\s*MEMORY\s*:', src, re.M))
    for with_list in ([True, False] if want_list else [False]):
        cmd = [find_uasm(), '-nologo', '-q', '-W2', '-I' + INC, '-I' + os.path.dirname(path),
               '-mz' if exe else '-bin', '-Fo' + out] + (['-Fl' + lst] if with_list else []) + [asm]
        r = subprocess.run(cmd, capture_output=True, text=True, errors='replace')
        msg = re.sub(r'\x1b\[[0-9;]*m', '', r.stdout + r.stderr)       # colours of the Linux build
        msg = '\n'.join(l for l in msg.split('\n') if l.strip() and not re.match(
            r'\s*(UASM v|Portions Copyright|Source code is available)', l)).strip()
        if not (with_list and 'buffer overflow' in msg):
            break
    if r.returncode or not os.path.exists(out):
        return None, msg, None, exe
    return open(out, 'rb').read(), msg, symbols(lst) if with_list else {}, exe


def symbols(lst):
    """Relative positions of the labels in the listing file (upper-cased)."""
    syms = {}
    try:
        text = open(lst, encoding='latin-1').read()
    except OSError:
        return syms
    part = text.split('Symbols:', 1)[-1] if 'Symbols:' in text else ''
    for m in re.finditer(r'^\s*([A-Za-z_@$?][\w@$?]*)\s[\s.]*\s(?:Byte|Word|DWord|QWord|Near|Far|L Near|L Far|Proc|Number)(?:\[\d+\])?\s+([0-9A-Fa-f]+)h', part, re.M):
        syms[m.group(1).upper()] = int(m.group(2), 16)
    for m in re.finditer(r'^\s*([A-Za-z_@$?][\w@$?]*)\s[\s.]*\sP (?:Near|Far)\s+([0-9A-Fa-f]{4,8})\b', part, re.M):
        syms[m.group(1).upper()] = int(m.group(2), 16)          # PROC names
    return syms


# ---------------------------------------------------------------- directives

def directives(src):
    d = {'input': b'', 'ports': {}, 'regs': [], 'mem': [], 'limit': None, 'compile_only': False}
    for l in src.split('\n'):
        m = re.match(r'\s*;\s*([A-Z]+(?: \d+)?)\s*:\s*(.*?)\s*$', l)
        if not m:
            if re.match(r'\s*;\s*RUN:\s*compile only', l, re.I):
                d['compile_only'] = True
            continue
        key, val = m.group(1), m.group(2)
        if key == 'INPUT':
            d['input'] += ast.literal_eval(val).encode('latin-1')
        elif key.startswith('PORT '):
            d['ports'][int(key.split()[1], 0)] = [int(x, 0) if not x.lower().endswith('h') else int(x[:-1], 16)
                                                   for x in val.replace(',', ' ').split()]
        elif key == 'REGISTERS':
            d['regs'] += val.split()
        elif key == 'MEMORY':
            p = val.split()
            d['mem'].append((p[0], int(p[1]) if len(p) > 1 else 1))
        elif key == 'LIMIT':
            d['limit'] = int(val.replace('.', '').replace('_', ''))
        elif key == 'RUN':
            d['compile_only'] = 'compile' in val
    return d


def expected(src):
    m = re.search(r'^\s*;\s*Expected output\s*(?:\([^)]*\))?\s*:\s*\n(.*)\Z', src, re.M | re.S | re.I)
    if not m:
        return None
    out = []
    for l in m.group(1).split('\n'):
        if not l.strip():
            continue
        if not re.match(r'\s*;', l):
            break
        out.append(re.sub(r'^\s*; ?', '', l).rstrip())
    while out and not out[-1]:
        out.pop()
    return out


# ---------------------------------------------------------------- machine

class Machine:
    def __init__(self, image, exe, d):
        self.d = d
        self.keys = bytearray(d['input'])
        self.screen = [[]]
        self.row = self.col = 0
        self.ports_in = {p: list(v) for p, v in d['ports'].items()}
        self.outs = []
        self.printer = bytearray()
        self.files = {}
        self.handles = {}
        self.next_handle = 5
        self.ticks = 0
        self.done = None
        self.error = None
        self.restart = False
        self.pending = None
        mu = self.mu = Uc(UC_ARCH_X86, UC_MODE_16)
        # 1 MB of memory; 100000h-10FFFFh maps to the same first 64 KB: on the 8086 the address wraps at 20 bits
        self.ram = ctypes.create_string_buffer(0x100000)
        mu.mem_map_ptr(0, 0x100000, UC_PROT_ALL, ctypes.addressof(self.ram))
        mu.mem_map_ptr(0x100000, 0x10000, UC_PROT_ALL, ctypes.addressof(self.ram))
        # interrupt table: default routines at F000:n*4; NOPs live there and a hook services them
        for n in range(256):
            mu.mem_write(n * 4, (n * 4).to_bytes(2, 'little') + BIOS.to_bytes(2, 'little'))
        mu.mem_write(BIOS * 16, b'\x90' * 1024)
        mu.mem_write(0x400 + 0x4A, (COLS).to_bytes(2, 'little'))       # BIOS data area: number of columns
        mu.mem_write(0x400 + 0x84, bytes([24]))                        # number of rows - 1
        psp = bytearray(256)
        psp[0:2] = b'\xcd\x20'
        psp[0x80] = 0
        psp[0x81] = 0x0D
        mu.mem_write(PSP * 16, bytes(psp))
        if exe:
            self.load_exe(image)
        else:
            mu.mem_write(PSP * 16 + 0x100, image)
            for r in (UC_X86_REG_CS, UC_X86_REG_DS, UC_X86_REG_ES, UC_X86_REG_SS):
                mu.reg_write(r, PSP)
            mu.reg_write(UC_X86_REG_IP, 0x100)
            mu.reg_write(UC_X86_REG_SP, 0xFFFE)
            mu.mem_write(PSP * 16 + 0xFFFE, b'\0\0')
        self.data_seg = mu.reg_read(UC_X86_REG_DS) if not exe else self.load_seg
        mu.reg_write(UC_X86_REG_EFLAGS, 0x0202)
        mu.hook_add(UC_HOOK_INTR, self.on_int)
        mu.hook_add(UC_HOOK_INSN, self.on_in, None, 1, 0, UC_X86_INS_IN)
        mu.hook_add(UC_HOOK_INSN, self.on_out, None, 1, 0, UC_X86_INS_OUT)
        mu.hook_add(UC_HOOK_CODE, self.on_bios, None, BIOS * 16, BIOS * 16 + 1023)

    def load_exe(self, img):
        mu = self.mu
        if img[:2] != b'MZ':
            raise Stop('no EXE header')
        w = lambda o: int.from_bytes(img[o:o + 2], 'little')
        last, pages, nrel, hdr = w(2), w(4), w(6), w(8) * 16
        ss, sp, ip, cs, rel = w(14), w(16), w(20), w(22), w(24)
        size = pages * 512 - (512 - last if last else 0)
        module = img[hdr:size]
        seg = self.load_seg = PSP + 0x10
        mu.mem_write(seg * 16, module)
        for i in range(nrel):
            off, s = w(rel + i * 4), w(rel + i * 4 + 2)
            a = (seg + s) * 16 + off
            v = int.from_bytes(mu.mem_read(a, 2), 'little')
            mu.mem_write(a, ((v + seg) & 0xFFFF).to_bytes(2, 'little'))
        mu.reg_write(UC_X86_REG_CS, seg + cs)
        mu.reg_write(UC_X86_REG_IP, ip)
        mu.reg_write(UC_X86_REG_SS, seg + ss)
        mu.reg_write(UC_X86_REG_SP, sp)
        mu.reg_write(UC_X86_REG_DS, PSP)
        mu.reg_write(UC_X86_REG_ES, PSP)

    # ---- helpers
    def r(self, n):
        return self.mu.reg_read(REGS[n])

    def w(self, n, v):
        self.mu.reg_write(REGS[n], v)

    def lin(self, seg, off):
        return (seg * 16 + (off & 0xFFFF)) & 0xFFFFF

    def rd(self, a, n):
        return bytes(self.mu.mem_read(a, n))

    def push(self, v):
        sp = (self.r('SP') - 2) & 0xFFFF
        self.w('SP', sp)
        self.mu.mem_write(self.lin(self.r('SS'), sp), (v & 0xFFFF).to_bytes(2, 'little'))

    def pop(self):
        sp = self.r('SP')
        v = int.from_bytes(self.rd(self.lin(self.r('SS'), sp), 2), 'little')
        self.w('SP', (sp + 2) & 0xFFFF)
        return v

    def set_flag(self, name, on, stacked=False):
        if stacked:                       # copy of the flags that IRET will restore
            a = self.lin(self.r('SS'), self.r('SP') + 4)
            f = int.from_bytes(self.rd(a, 2), 'little')
            f = f | (1 << FLAGS[name]) if on else f & ~(1 << FLAGS[name])
            self.mu.mem_write(a, f.to_bytes(2, 'little'))
        else:
            f = self.mu.reg_read(UC_X86_REG_EFLAGS)
            f = f | (1 << FLAGS[name]) if on else f & ~(1 << FLAGS[name])
            self.mu.reg_write(UC_X86_REG_EFLAGS, f)

    def vector(self, n):
        v = self.rd(n * 4, 4)
        return int.from_bytes(v[2:], 'little'), int.from_bytes(v[:2], 'little')

    # ---- screen
    def cell(self, r, c, ch):
        while len(self.screen) <= r:
            self.screen.append([])
        line = self.screen[r]
        while len(line) <= c:
            line.append(' ')
        line[c] = ch

    def tty(self, b):
        if b == 13:
            self.col = 0
        elif b == 10:
            self.row += 1
        elif b == 8:
            self.col = max(0, self.col - 1)
        elif b == 7:
            pass
        else:
            self.cell(self.row, self.col, chr(b) if 32 <= b < 127 else ('?' if b < 32 else bytes([b]).decode('cp437')))
            self.col += 1
            if self.col >= COLS:
                self.col = 0
                self.row += 1

    def text(self):
        lines = [''.join(l).rstrip() for l in self.screen]
        while lines and not lines[-1]:
            lines.pop()
        return lines

    # ---- keyboard
    def key(self, block=True):
        if not self.keys:
            if block:
                raise Stop('input exhausted: the program wants to read from the keyboard (INPUT directive?)')
            return None
        return self.keys.pop(0)

    # ---- interrupts
    def on_int(self, mu, n, _):
        try:
            seg, off = self.vector(n)
            if n == 0 and (seg, off) == (BIOS, 0):
                raise Stop('divide error (INT 0)')
            if n == 0:
                # unicorn (like the 80286+) leaves DIV's own address; the 8086 pushes the
                # address of the next instruction, so IRET does not return to the DIV.
                self.w('IP', (self.r('IP') + self.div_length()) & 0xFFFF)
            if (seg, off) == (BIOS, n * 4):
                self.service(n, stacked=False)
            else:                                   # a real INT to the routine the program installed
                self.pending = lambda: self.dispatch(seg, off)
                self.restart = True
                mu.emu_stop()
        except Stop as e:
            self.stop(str(e))

    def div_length(self):
        """Byte length of the (prefixed) DIV/IDIV instruction at CS:IP."""
        a = self.lin(self.r('CS'), self.r('IP'))
        code = self.rd(a, 8)
        i = 0
        while code[i] in (0x26, 0x2E, 0x36, 0x3E, 0xF0, 0xF2, 0xF3):
            i += 1
        if code[i] in (0xD4,):                        # AAM 0 also raises a divide error
            return i + 2
        modrm = code[i + 1]
        mod, rm = modrm >> 6, modrm & 7
        disp = {0: 2 if rm == 6 else 0, 1: 1, 2: 2, 3: 0}[mod]
        return i + 2 + disp

    def on_bios(self, mu, addr, size, _):
        """The program reached a default routine by far JMP/CALL or INT: service it, then IRET."""
        off = addr - BIOS * 16
        if off % 4:
            return
        try:
            self.service(off // 4, stacked=True)
            self.pending = self.iret
            self.restart = True
            mu.emu_stop()
        except Stop as e:
            self.stop(str(e))

    def dispatch(self, seg, off):
        # writing CS inside a hook crashes unicorn; so this is done after emulation has stopped
        self.push(self.mu.reg_read(UC_X86_REG_EFLAGS))
        self.push(self.r('CS'))
        self.push(self.r('IP'))
        self.set_flag('IF', False)
        self.set_flag('TF', False)
        self.w('CS', seg)
        self.w('IP', off)

    def iret(self):
        ip, cs, fl = self.pop(), self.pop(), self.pop()
        self.w('IP', ip)
        self.w('CS', cs)
        self.mu.reg_write(UC_X86_REG_EFLAGS, fl)

    def stop(self, err=None, ok=False):
        if ok:
            self.done = True
        else:
            self.error = err
        self.mu.emu_stop()

    def service(self, n, stacked):
        fn = {0x10: self.int10, 0x16: self.int16, 0x21: self.int21, 0x20: lambda s: self.stop(ok=True),
              0x1A: self.int1a, 0x15: self.int15, 0x11: lambda s: self.w('AX', 0x0021),
              0x12: lambda s: self.w('AX', 640), 0x08: self.int08, 0x1C: lambda s: None,
              0x05: lambda s: None, 0x01: lambda s: None, 0x03: lambda s: None,
              0x04: lambda s: None}.get(n)                # in DOS the default for INT 1/3/4 is IRET
        if fn is None:
            raise Stop('unsupported interrupt INT %02Xh (AH=%02Xh)' % (n, self.r('AH')))
        fn(stacked)

    def int08(self, stacked):
        self.ticks += 1
        a = 0x46C
        t = (int.from_bytes(self.rd(a, 4), 'little') + 1) & 0xFFFFFFFF
        self.mu.mem_write(a, t.to_bytes(4, 'little'))

    def int10(self, stacked):
        ah, al = self.r('AH'), self.r('AL')
        if ah == 0x0E:
            self.tty(al)
        elif ah == 0x02:
            self.row, self.col = self.r('DH'), self.r('DL')
        elif ah == 0x03:
            self.w('DH', self.row & 0xFF)
            self.w('DL', self.col)
            self.w('CX', 0x0607)
        elif ah in (0x09, 0x0A):
            for i in range(max(1, self.r('CX'))):
                self.cell(self.row, self.col + i, chr(al) if 32 <= al < 127 else '?')
        elif ah == 0x08:
            line = self.screen[self.row] if self.row < len(self.screen) else []
            self.w('AL', ord(line[self.col]) if self.col < len(line) else 32)
            self.w('AH', 0x07)
        elif ah in (0x06, 0x07):
            top, left, bot, right = self.r('CH'), self.r('CL'), self.r('DH'), self.r('DL')
            if al == 0 or al > bot - top:
                for rr in range(top, bot + 1):
                    for cc in range(left, min(right, COLS - 1) + 1):
                        if rr < len(self.screen) and cc < len(self.screen[rr]):
                            self.screen[rr][cc] = ' '
            else:
                raise Stop('INT 10h scrolling (AL>0) is not supported')
        elif ah == 0x00:
            self.screen, self.row, self.col = [[]], 0, 0
        elif ah == 0x0F:
            self.w('AL', 3)
            self.w('AH', COLS)
            self.w('BH', 0)
        elif ah == 0x13:
            es, bp, cx = self.r('ES'), self.r('BP'), self.r('CX')
            r0, c0 = self.row, self.col
            self.row, self.col = self.r('DH'), self.r('DL')
            data = self.rd(self.lin(es, bp), cx * (2 if al & 2 else 1))
            for i in range(cx):
                self.tty(data[i * 2] if al & 2 else data[i])
            if not al & 1:
                self.row, self.col = r0, c0
        elif ah in (0x01, 0x05, 0x0B, 0x0C, 0x10, 0x11, 0x12):
            pass                                         # cursor shape, page, palette, pixel
        else:
            raise Stop('unsupported INT 10h AH=%02Xh' % ah)

    def int16(self, stacked):
        ah = self.r('AH')
        if ah in (0x00, 0x10):
            k = self.key()
            self.w('AX', k)
        elif ah in (0x01, 0x11):
            if self.keys:
                self.w('AX', self.keys[0])
                self.set_flag('ZF', False, stacked)
            else:
                self.set_flag('ZF', True, stacked)
        elif ah in (0x02, 0x12):
            self.w('AL', 0)
        else:
            raise Stop('unsupported INT 16h AH=%02Xh' % ah)

    def int1a(self, stacked):
        ah = self.r('AH')
        if ah == 0x00:
            t = int.from_bytes(self.rd(0x46C, 4), 'little')
            self.w('CX', t >> 16)
            self.w('DX', t & 0xFFFF)
            self.w('AL', 0)
        elif ah == 0x02:
            self.w('CH', 0x12)
            self.w('CL', 0x00)
            self.w('DH', 0x00)
            self.set_flag('CF', False, stacked)
        elif ah == 0x04:
            self.w('CX', 0x2026)
            self.w('DX', 0x0101)
            self.set_flag('CF', False, stacked)
        else:
            raise Stop('unsupported INT 1Ah AH=%02Xh' % ah)

    def int15(self, stacked):
        if self.r('AH') == 0x86:                          # wait: the time counts as elapsed
            self.set_flag('CF', False, stacked)
        else:
            raise Stop('unsupported INT 15h AH=%02Xh' % self.r('AH'))

    def asciiz(self, seg, off):
        out = bytearray()
        a = self.lin(seg, off)
        while True:
            b = self.rd(a + len(out), 1)[0]
            if b == 0:
                return bytes(out)
            out.append(b)

    def int21(self, stacked):
        ah, al = self.r('AH'), self.r('AL')
        ds = self.r('DS')
        cf = lambda on: self.set_flag('CF', on, stacked)
        if ah in (0x4C, 0x00, 0x31):
            self.stop(ok=True)
        elif ah == 0x02:
            self.tty(self.r('DL'))
            self.w('AL', self.r('DL'))
        elif ah == 0x09:
            a = self.lin(ds, self.r('DX'))
            i = 0
            while True:
                b = self.rd(a + i, 1)[0]
                if b == ord('$'):
                    break
                self.tty(b)
                i += 1
                if i > 65535:
                    raise Stop('INT 21h/09h: $ not found')
            self.w('AL', ord('$'))
        elif ah in (0x01, 0x07, 0x08):
            k = self.key()
            self.w('AL', k)
            if ah == 0x01:
                self.tty(k)
        elif ah == 0x06:
            if self.r('DL') == 0xFF:
                k = self.key(block=False)
                if k is None:
                    self.w('AL', 0)
                    self.set_flag('ZF', True, stacked)
                else:
                    self.w('AL', k)
                    self.set_flag('ZF', False, stacked)
            else:
                self.tty(self.r('DL'))
        elif ah == 0x0A:
            a = self.lin(ds, self.r('DX'))
            mx = self.rd(a, 1)[0]
            buf = bytearray()
            while True:
                k = self.key()
                if k == 13:
                    break
                if k == 8:
                    if buf:
                        buf.pop()
                        self.tty(8); self.tty(32); self.tty(8)
                    continue
                if len(buf) < mx - 1:
                    buf.append(k)
                    self.tty(k)
            self.tty(13)
            self.mu.mem_write(a + 1, bytes([len(buf)]) + bytes(buf) + b'\r')
        elif ah == 0x0B:
            self.w('AL', 0xFF if self.keys else 0)
        elif ah == 0x0C:
            self.w('AH', al)
            if al in (0x01, 0x06, 0x07, 0x08, 0x0A):
                self.int21(stacked)
        elif ah == 0x25:
            self.mu.mem_write(al * 4, self.r('DX').to_bytes(2, 'little') + ds.to_bytes(2, 'little'))
        elif ah == 0x35:
            seg, off = self.vector(al)
            self.w('ES', seg)
            self.w('BX', off)
        elif ah == 0x2A:
            self.w('CX', 2026)
            self.w('DH', 1)
            self.w('DL', 1)
            self.w('AL', 4)
        elif ah == 0x2C:
            self.w('CH', 12)
            self.w('CL', 0)
            self.w('DH', 0)
            self.w('DL', 0)
        elif ah == 0x05:                                # printer: a separate output
            self.printer.append(self.r('DL'))
        elif ah == 0x30:
            self.w('AX', 0x0005)
        elif ah in (0x3C, 0x3D):                        # files live in memory: nothing is ever written to disk
            name = self.asciiz(ds, self.r('DX')).decode('latin-1').upper()
            if ah == 0x3D and name not in self.files:
                self.w('AX', 2)
                cf(True)
                return
            if ah == 0x3C:
                self.files[name] = bytearray()
            h = self.next_handle
            self.next_handle += 1
            self.handles[h] = [name, 0]
            self.w('AX', h)
            cf(False)
        elif ah == 0x3E:
            self.handles.pop(self.r('BX'), None)
            cf(False)
        elif ah == 0x40:
            bx, cx = self.r('BX'), self.r('CX')
            data = self.rd(self.lin(ds, self.r('DX')), cx)
            if bx in (1, 2):
                for b in data:
                    self.tty(b)
            elif bx in self.handles:
                name, pos = self.handles[bx]
                f = self.files[name]
                f[pos:pos + cx] = data
                self.handles[bx][1] = pos + cx
            else:
                self.w('AX', 6)
                cf(True)
                return
            self.w('AX', cx)
            cf(False)
        elif ah == 0x3F:
            bx, cx = self.r('BX'), self.r('CX')
            if bx == 0:
                data = bytearray()
                while len(data) < cx:
                    k = self.key()
                    data.append(k)
                    self.tty(k)
                    if k == 13:
                        data.append(10)
                        self.tty(10)
                        break
                data = bytes(data[:cx])
            elif bx in self.handles:
                name, pos = self.handles[bx]
                data = bytes(self.files[name][pos:pos + cx])
                self.handles[bx][1] = pos + len(data)
            else:
                self.w('AX', 6)
                cf(True)
                return
            self.mu.mem_write(self.lin(ds, self.r('DX')), data)
            self.w('AX', len(data))
            cf(False)
        elif ah == 0x41:
            name = self.asciiz(ds, self.r('DX')).decode('latin-1').upper()
            cf(self.files.pop(name, None) is None)
        elif ah == 0x42:
            h = self.r('BX')
            pos = (self.r('CX') << 16) | self.r('DX')
            name, cur = self.handles[h]
            base = {0: 0, 1: cur, 2: len(self.files[name])}[al]
            self.handles[h][1] = base + pos
            self.w('AX', (base + pos) & 0xFFFF)
            self.w('DX', (base + pos) >> 16)
            cf(False)
        else:
            raise Stop('unsupported INT 21h AH=%02Xh' % ah)

    # ---- ports
    def on_in(self, mu, port, size, _):
        seq = self.ports_in.get(port)
        if not seq:
            return 0
        v = seq.pop(0) if len(seq) > 1 else seq[0]
        return v

    def on_out(self, mu, port, size, value, _):
        self.outs.append((port, size, value))

    # ---- run
    def run(self, limit):
        budget = limit or DEFAULT_LIMIT
        while self.done is None and self.error is None:
            if budget <= 0:
                if limit:
                    self.done = True
                    break
                self.error = 'instruction limit exceeded (%d): endless loop? (LIMIT directive)' % DEFAULT_LIMIT
                break
            self.restart = False
            cs, ip = self.r('CS'), self.r('IP')
            try:
                self.mu.emu_start(self.lin(cs, ip), 0xFFFFFFFF, count=min(CHUNK, budget))
            except UcError as e:
                if 'HLT' in str(e) or 'UC_ERR_HOOK' in str(e) and self.done:
                    self.done = True
                    break
                if self.r('CS') * 16 + self.r('IP') and self.rd(self.lin(self.r('CS'), self.r('IP')), 1) == b'\xf4':
                    self.done = True
                    break
                self.error = 'CPU error: %s (CS:IP=%04X:%04X)' % (e, self.r('CS'), self.r('IP'))
                break
            if self.done is None and self.error is None and \
                    self.rd(self.lin(self.r('CS'), self.r('IP') - 1), 1) == b'\xf4':
                self.done = True                     # HLT: unicorn stops, the program ends
                break
            if self.pending:
                fn, self.pending = self.pending, None
                fn()
            if self.restart:
                budget -= 50
                continue
            budget -= min(CHUNK, budget)
            # timer interrupt: one tick every CHUNK instructions (0040:006Ch advances); if the program
            # installed an INT 08h or 1Ch routine, it is entered like a real interrupt
            if self.mu.reg_read(UC_X86_REG_EFLAGS) & 0x200 and self.done is None:
                self.int08(False)
                for n in (0x08, 0x1C):
                    if self.vector(n) != (BIOS, n * 4):
                        seg, off = self.vector(n)
                        self.dispatch(seg, off)
                        break

    def video(self):
        """Draws characters written straight to B800h text memory onto the screen (80x25)."""
        vram = self.rd(0xB8000, COLS * 25 * 2)
        for i in range(COLS * 25):
            ch = vram[i * 2]
            if ch:
                self.cell(i // COLS, i % COLS, chr(ch) if 32 <= ch < 127 else '?')

    def report(self, syms):
        self.video()
        lines = self.text()
        if self.printer:
            text = self.printer.decode('latin-1')
            text = text.replace('\r\n', '\n').replace('\n\r', '\n').replace('\r', '\n')
            lines += [('PRINTER: ' + l).rstrip() for l in text.rstrip('\n').split('\n')]
        for port, size, value in self.outs[:300]:
            lines.append('OUT %d <- %0*Xh' % (port, 4 if size == 2 else 2, value))
        if len(self.outs) > 300:
            lines.append('... (%d more OUT)' % (len(self.outs) - 300))
        for name in self.d['regs']:
            u = name.upper()
            if u in FLAGS:
                lines.append('%s=%d' % (u, (self.mu.reg_read(UC_X86_REG_EFLAGS) >> FLAGS[u]) & 1))
            elif u in REGS:
                v = self.r(u)
                lines.append('%s=%0*Xh' % (u, 2 if u[1] in 'LH' else 4, v))
            else:
                lines.append('%s=? (unknown register)' % u)
        for label, n in self.d['mem']:
            off = syms.get(label.upper())
            if off is None:
                lines.append('%s: ? (label not found)' % label)
                continue
            data = self.rd(self.lin(self.r('DS'), off), n)
            lines.append('%s: %s' % (label, ' '.join('%02Xh' % b for b in data)))
        return lines


# ---------------------------------------------------------------- main

def check(path, verbose, tmp):
    rel = os.path.relpath(path, REPO).replace('\\', '/')
    src = open(path, encoding='utf-8').read()
    d = directives(src)
    image, msg, syms, exe = assemble(path, tmp)
    if image is None:
        return rel, 'COMPILE FAILED', msg.split('\n')[:8]
    if d['compile_only']:
        return rel, 'compiled', []
    m = Machine(image, exe, d)
    try:
        m.run(d['limit'])
    except Stop as e:
        m.error = str(e)
    got = m.report(syms)
    if verbose:
        print('--- %s' % rel)
        print('\n'.join(got))
    if m.error:
        return rel, 'RUN FAILED', [m.error] + got[-5:]
    exp = expected(src)
    if exp is None:
        return rel, 'NO EXPECTED', got[:10]
    if exp != got:
        import difflib
        return rel, 'OUTPUT DIFFERS', list(difflib.unified_diff(exp, got, 'expected', 'actual', lineterm='', n=1))[:30]
    return rel, 'ok', []


def main():
    args = sys.argv[1:]
    verbose = '-v' in args
    args = [a for a in args if a != '-v']
    paths = []
    for a in args or sorted(glob.glob(os.path.join(REPO, 'Chapter*'))):
        a = a if os.path.isabs(a) else os.path.join(REPO, a)
        paths += sorted(glob.glob(os.path.join(a, '*.asm'))) if os.path.isdir(a) else [a]
    tmp = tempfile.mkdtemp()
    bad = []
    summary = os.environ.get('GITHUB_STEP_SUMMARY')
    rows = []
    for p in paths:
        rel, status, detail = check(p, verbose, tmp)
        print('%-15s %s' % (status, rel))
        for l in detail:
            print('    ' + l)
        rows.append('| `%s` | %s |' % (rel, status if status in ('ok', 'compiled') else '**%s**' % status))
        if status not in ('ok', 'compiled'):
            bad.append((rel, status, detail))
    shutil.rmtree(tmp, ignore_errors=True)
    print('\n%d programs, %d with problems' % (len(paths), len(bad)))
    if summary:
        with open(summary, 'a', encoding='utf-8') as f:
            f.write('\n## 8086 programs\n\n| Program | Result |\n|---|---|\n' + '\n'.join(rows) + '\n')
    if bad and os.environ.get('GITHUB_ACTIONS'):
        msg = '%0A'.join('%s: %s %s' % (r, s, ' / '.join(d[:3])) for r, s, d in bad)
        print('::error title=8086 programs failed::' + msg.replace('\n', ' '))
    sys.exit(1 if bad else 0)


if __name__ == '__main__':
    main()
