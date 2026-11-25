; RUN: compile only
; FAULTY CODE: a near CALL pushes only IP, but the procedure returns with RETF. After IP, RETF pulls
; DOS's 0000h as CS, the processor jumps to 0000:0106h (the interrupt vector table) and the
; program crashes. That is why it is only compiled. The correct form: far_return.asm (with PUSH CS).
; Slides: Chapter 8 Procedures, slide "Type Mismatch: Code Trace".
ORG  100h
MOV  AX, 5
CALL farp        ; near CALL: IP only
ADD  AX, 1
RET
farp PROC
SHL  AX, 1
RETF             ; pops IP and CS!
farp ENDP
