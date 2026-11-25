; Stack frame pattern: BP as the frame pointer, SUB SP for local space, MOV SP, BP to release it,
; RET 4 so the callee drops the two parameters. The stack stays balanced.
; Slides: Chapter 8 Procedures, slide "Stack Frame".
ORG  100h         ; not in the slides: .COM program
PUSH AX           ; not in the slides: 1st parameter
PUSH AX           ; not in the slides: 2nd parameter
MOV  AX, 7        ; not in the slides
CALL frame        ; not in the slides
RET               ; not in the slides: return to DOS (if RET 4 did not drop the parameters it would return to the wrong address)
frame PROC        ; not in the slides
PUSH BP
MOV  BP, SP
SUB  SP, 4        ; local space
MOV  [BP-2], AX   ; local 1
; ...
MOV  SP, BP       ; drop the locals
POP  BP
RET  4            ; drop the 2 parameters
frame ENDP        ; not in the slides

; REGISTERS: AX BP SP
; Expected output:
; AX=0007h
; BP=0000h
; SP=0000h
