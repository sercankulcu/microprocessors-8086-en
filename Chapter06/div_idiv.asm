; DIV, CWD and IDIV: 2000 / 9 = 222 remainder 2; -2000 / 9 = -222 remainder -2.
; The last two instructions in the slides are deliberately wrong: DIV BX without clearing
; DX = FFFEh makes the quotient not fit in 16 bits and the processor raises INT 0. Those two
; lines are commented out so that the program does not stop.
; Source: Chapter 6 slides, "DIV and IDIV: Code Trace".
; REGISTERS: AX DX
org 100h         ; not in the slides: .COM program
MOV  AX, 2000
XOR  DX, DX      ; DX:AX = 2000
MOV  BX, 9
DIV  BX          ; unsigned division
MOV  AX, -2000
CWD              ; sign-extend
IDIV BX          ; signed division
; MOV  AX, 2000    ; DX was not cleared!
; DIV  BX          ; ERROR: DX:AX = FFFE07D0h, quotient does not fit -> INT 0
; The correct way:
; MOV  AX, 2000
; XOR  DX, DX
; DIV  BX
RET

; Expected output:
; AX=FF22h
; DX=FFFEh
