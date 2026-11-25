; JCXZ keeps a LOOP-based loop from being entered with CX = 0 (the body would run 65,536 times).
; A DEC-JNZ loop can use any register (here BX) as the counter and it preserves CF.
; Slides: Chapter 7 Flow Control, slides "JCXZ and LOOP / DEC-JNZ" (general pattern) and
; "JCXZ and DEC-JNZ: Code Trace" (this program).
ORG  100h        ; not in the slides: .COM program
MOV  CX, 0       ; n = 0
MOV  AX, 0
JCXZ skip        ; CX = 0 -> do not enter
again: INC AX
LOOP again
skip: MOV BX, 3  ; n = 3, counter BX
STC              ; CF = 1
again2: INC AX
DEC  BX          ; CF is preserved
JNZ  again2
RET

; REGISTERS: AX BX CX CF ZF

; Expected output:
; AX=0003h
; BX=0000h
; CX=0000h
; CF=1
; ZF=1
