; Is FFh 255 or -1? ADD (unsigned, CF) or CBW/NEG (signed) interprets the bit pattern.
; Slides 4.2 Variables, slide "Code Trace: Is FFh 255 or -1?".
; Intermediate step (after ADD AL, 1): AL = 00h, CF = 1, OF = 0, ZF = 1.
ORG 100h
MOV AL, x        ; FFh
ADD AL, 1        ; 255 + 1 ?
MOV AL, x
CBW              ; signed: -1
MOV BX, y        ; FFFEh
NEG BX           ; -(-2)
RET
x DB -1
y DW -2

; REGISTERS: AX BX CF OF ZF
; MEMORY: x 3

; Expected output:
; AX=FFFFh
; BX=0002h
; CF=1
; OF=0
; ZF=0
; x: FFh FEh FFh
