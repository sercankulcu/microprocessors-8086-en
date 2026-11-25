; The two expansions of the DELAY macro whose first line is LOCAL: the labels got the names
; ??0000 and ??0001, and each JNZ returns to its own copy's label. 3 + 2 = 5 DEC in total.
; Slides 9.1 "DELAY and LOCAL: Code Trace".
org 100h
mov cx, 3
??0000: dec cx   ; DELAY (copy 1)
jnz ??0000
mov cx, 2
??0001: dec cx   ; DELAY (copy 2)
jnz ??0001
ret

; REGISTERS: CX ZF

; Expected output:
; CX=0000h
; ZF=1
