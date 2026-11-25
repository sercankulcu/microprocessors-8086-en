; Which instruction touches the flags? MOV and NOT leave the flags alone; INC and DEC
; do not touch CF; ADD rewrites all the status flags; STC/CLC change only CF.
; Final state: AL = FFh but ZF is still 1 (NOT did not change the flags).
; Source: Chapter 3.2 Assembly, "Flag-Preserving Instructions: Code Trace"

ORG 100h
STC              ; CF = 1
MOV AL, 0FFh     ; flags kept
INC AL           ; CF untouched
MOV CX, 0        ; ZF kept
DEC AL
ADD AL, 1        ; new CF
CLC
NOT AL           ; flags kept
RET

; REGISTERS: AL CF ZF SF AF PF

; Expected output:
; AL=FFh
; CF=0
; ZF=1
; SF=0
; AF=1
; PF=1
