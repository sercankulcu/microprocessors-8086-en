; Implicit operands: MUL BL takes the multiplicand from AL and writes the result to AX
; (12 x 10 = 120), SHR AX, CL takes the shift count from CL (120 / 4 = 30), LOOP counts
; down CX (30 + 3 = 33).
; Source: Chapter 3.2 Assembly, "Implicit Operands: Code Trace"

ORG 100h
MOV AL, 12
MOV BL, 10
MUL BL         ; AX = AL × BL
MOV CL, 2
SHR AX, CL     ; count in CL
MOV CX, 3      ; LOOP counter
again:
ADD AX, 1
LOOP again     ; CX decrements
RET

; REGISTERS: AX BX CX

; Expected output:
; AX=0021h
; BX=000Ah
; CX=0000h
