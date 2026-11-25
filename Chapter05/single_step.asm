; Setting TF through the FLAGS on the stack (PUSHF / POP / OR / PUSH / POPF). While TF = 1, INT 1
; occurs after every instruction; here INT 1 is the default routine (just IRET), so the program
; single-steps to its end and TF stays 1.
; Source: Chapter 5.1 slides, "Single Step and Breakpoint".
; REGISTERS: TF
org 100h          ; not in the slides: a .COM program
PUSHF
POP  AX
OR   AH, 01h      ; bit 8 = TF
PUSH AX
POPF              ; TF = 1
ret               ; not in the slides

; Expected output:
; TF=1
