; MAX2 MACRO p, q, r / LOCAL ok / MOV AX, p / CMP AX, q / JGE ok / MOV AX, q /
; ok: MOV r, AX / ENDM. The code below is the expansion of MAX2 x, y, m1 and MAX2 y, 4, m2.
; JGE compares signed: m1 = 7, m2 = 4. Slides 9.1 "The MAX2 Macro: Code Trace".
org 100h
mov ax, x      ; MAX2 x, y, m1
cmp ax, y
jge ??0000
mov ax, y
??0000: mov m1, ax
mov ax, y      ; MAX2 y, 4, m2
cmp ax, 4
jge ??0001
mov ax, 4
??0001: mov m2, ax
ret
x  dw 7
y  dw -3
m1 dw ?
m2 dw ?

; REGISTERS: AX SF OF
; MEMORY: m1 2
; MEMORY: m2 2

; Expected output:
; AX=0004h
; SF=1
; OF=0
; m1: 07h 00h
; m2: 04h 00h
