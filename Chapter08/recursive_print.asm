; Recursive printing: show divides AX by 10, pushes the digit on the stack, and first prints the upper
; digits by calling itself. 472 -> 472 on the screen.
; Slides: Chapter 8 Procedures, slide "Recursive Printing: Code Trace".
ORG  100h
MOV  AX, 472
CALL show
RET
show PROC        ; In: AX (unsigned)
XOR  DX, DX
MOV  BX, 10
DIV  BX          ; AX = quotient, DX = digit
PUSH DX
OR   AX, AX      ; more digits?
JZ   done
CALL show        ; upper digits first
done: POP AX
ADD  AL, '0'
MOV  AH, 0Eh
INT  10h
RET
show ENDP

; REGISTERS: AX DX
; Expected output:
; 472
; AX=0E32h
; DX=0004h
