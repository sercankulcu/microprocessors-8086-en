; Single exit point: whichever path find leaves by, the POPs are done at the done label.
; 7 is searched for in arr = 3, 9, 7, 1, 4: CF = 1 (found), BX = 2; CX and SI (arr = 011Fh) are preserved.
; Slides: Chapter 8 Procedures, slide "Single Exit Point: Code Trace".
ORG  100h
LEA  SI, arr
MOV  CX, 5
MOV  AL, 7
CALL find        ; CF = 1: found
RET
find PROC        ; In: SI, CX, AL
PUSH CX
PUSH SI
XOR  BX, BX      ; Out: BX = index
scan: CMP [SI], AL
JE   found
INC  SI
INC  BX
LOOP scan
CLC              ; not found
JMP  done
found: STC
done: POP SI     ; single exit point
POP  CX
RET
find ENDP
arr DB 3, 9, 7, 1, 4

; REGISTERS: BX CX SI CF
; Expected output:
; BX=0002h
; CX=0005h
; SI=011Fh
; CF=1
