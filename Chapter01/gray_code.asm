; Gray code: G = B xor (B >> 1). Gray(11) = 1110b, Gray(12) = 1010b;
; going from 11 to 12 only one bit changes in Gray code.
; Source: Chapter 1.2 Number Systems, "Gray Code: Code Trace"

ORG 100h
MOV AL, 1011b  ; 11
MOV BL, AL
SHR BL, 1      ; B >> 1
XOR BL, AL     ; G
MOV AL, 1100b  ; 12
MOV BH, AL
SHR BH, 1
XOR BH, AL     ; G
RET

; REGISTERS: AL BL BH

; Expected output:
; AL=0Ch
; BL=0Eh
; BH=0Ah
