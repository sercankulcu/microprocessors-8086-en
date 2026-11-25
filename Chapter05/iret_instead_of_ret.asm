; A common mistake: ending an ISR with RET instead of IRET. A near RET pops only IP;
; CS and FLAGS stay on the stack (SP = FFFAh, not FFFEh) and IF stays 0.
; The code in the slides is deliberately wrong; it can still be run because it stops at HLT.
; Source: Chapter 5.1 slides, "ISR Ending with RET: Code Trace".
; REGISTERS: SP IF
org 100h
mov ax, 0
mov es, ax
mov word ptr es:[61h*4], offset isr
mov word ptr es:[61h*4+2], cs
int 61h
hlt              ; SP = ?
isr:
ret              ; BUG!
; Correct: iret

; Expected output:
; SP=FFFAh
; IF=0
