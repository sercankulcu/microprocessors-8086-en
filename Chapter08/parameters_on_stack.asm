; Passing parameters on the stack: the caller pushes two parameters, SUM2 reads them through BP
; ([BP+6] = 7, [BP+4] = 3), the caller drops them with ADD SP, 4. Result AX = 10.
; Slides: Chapter 8 Procedures, slide "Passing Parameters on the Stack".
ORG  100h
MOV  AX, 7
PUSH AX          ; 1st parameter
MOV  AX, 3
PUSH AX          ; 2nd parameter
CALL SUM2
ADD  SP, 4       ; drop parameters
RET
SUM2 PROC
PUSH BP
MOV  BP, SP
MOV  AX, [BP+6]  ; 1st parameter
ADD  AX, [BP+4]  ; 2nd parameter
POP  BP
RET
SUM2 ENDP

; REGISTERS: AX BP SP
; Expected output:
; AX=000Ah
; BP=0000h
; SP=0000h
