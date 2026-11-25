; PUSH CS + a near CALL imitates the stack layout of a far call; RETF pops IP first, then CS.
; AX = 5 -> SHL -> 10 -> ADD 1 -> 11 = 000Bh.
; Slides: Chapter 8 Procedures, slide "Far Return: Code Trace".
ORG  100h
MOV  AX, 5
PUSH CS          ; first half of a far call
CALL farp        ; pushes IP
ADD  AX, 1
RET
farp PROC
SHL  AX, 1
RETF             ; IP first, then CS
farp ENDP

; REGISTERS: AX CS SP
; Expected output:
; AX=000Bh
; CS=0700h
; SP=0000h
