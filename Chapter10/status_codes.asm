; The bus cycle type each instruction produces (S2' S1' S0'): memory read, memory write, I/O
; read, I/O write, stack write, halt. Port 60h returns 5Ah; at the end AX = 125Ah, SP = FFFCh.
; Source: Chapter 10.1 8086 Pins, "Status Codes: Code Trace"
; PORT 96: 5Ah
; REGISTERS: AX SP
; MEMORY: data 4

org 100h
mov bx, 0200h
mov ax, [bx]      ; memory read
mov [bx+2], ax    ; memory write
in al, 60h        ; I/O read
out 61h, al       ; I/O write
push ax           ; write to the stack
hlt               ; halt
org 0200h          ; not on the slide: in the trace DS:0200h = 1234h
data dw 1234h, 0   ; not on the slide

; Expected output:
; OUT 97 <- 5Ah
; AX=125Ah
; SP=FFFCh
; data: 34h 12h 34h 12h
