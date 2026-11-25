; Frame with a local variable: x = 9 is stored in the local [BP-2], AX = x*x + x = 90 = 005Ah.
; Slides: Chapter 8 Procedures, slide "Frame with a Local Variable: Code Trace".
ORG  100h        ; not in the slides: .COM program
MOV  AX, 9
CALL sq_plus     ; AX = x*x + x
RET
sq_plus PROC
PUSH BP
MOV  BP, SP
SUB  SP, 2       ; local space [BP-2]
MOV  [BP-2], AX  ; local = x
MUL  AX          ; AX = x*x
ADD  AX, [BP-2]  ; + x
MOV  SP, BP      ; drop the local
POP  BP
RET
sq_plus ENDP

; REGISTERS: AX DX BP
; Expected output:
; AX=005Ah
; DX=0000h
; BP=0000h
