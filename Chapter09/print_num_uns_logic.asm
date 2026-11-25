; A stack-based method that gives the same output as PRINT_NUM_UNS: divide by 10, push the
; remainder, pop in reverse order and write. AX = 1205 -> 1205 on the screen.
; Slides 9.2 "PRINT_NUM_UNS Logic: Code Trace".
ORG  100h
MOV  AX, 1205    ; number to print
MOV  BX, 10
XOR  CX, CX      ; digit counter
divide: XOR DX, DX
DIV  BX          ; AX=quot, DX=rem
PUSH DX          ; push the digit
INC  CX
OR   AX, AX      ; quotient 0?
JNZ  divide
emit: POP AX      ; MSD first
ADD  AL, '0'
MOV  AH, 0Eh
INT  10h
LOOP emit
RET

; REGISTERS: AX CX DX

; Expected output:
; 1205
; AX=0E35h
; CX=0000h
; DX=0001h
