; AAM (6 x 9 = 54 -> 0504h), AAD (0702h -> 72 = 48h, then / 8 = 9) and DAA (packed BCD
; 19h + 28h = 41h -> 47h).
; Source: Chapter 6 slides, "AAM, AAD and DAA: Code Trace".
; REGISTERS: AX AF CF
org 100h         ; not in the slides: .COM program
MOV  AL, 6
MOV  BL, 9
MUL  BL          ; AX = 6 x 9
AAM              ; split into digits
MOV  AX, 0702h   ; '72' unpacked
AAD              ; convert to binary
MOV  BL, 8
DIV  BL
MOV  AL, 19h     ; packed 19
ADD  AL, 28h     ; + 28
DAA              ; BCD adjust
RET

; Expected output:
; AX=0047h
; AF=1
; CF=0
