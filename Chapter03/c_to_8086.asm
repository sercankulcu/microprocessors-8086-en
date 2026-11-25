; From C to 8086: while (i > 0) { sum += i; i -= 3; } becomes CMP + JLE + JMP.
; sum = 10 + 7 + 4 + 1 = 22 = 0016h; the loop ends when i = -2 (FFFEh).
; Source: Chapter 3.1 Programming Languages, "From C to 8086: Code Trace"

org 100h
mov bx, 0         ; sum = 0
mov cx, 10        ; i = 10
cond: cmp cx, 0   ; i > 0 ?
jle done
add bx, cx        ; sum += i
sub cx, 3         ; i -= 3
jmp cond
done: mov sum, bx
ret
sum dw ?

; REGISTERS: BX CX
; MEMORY: sum 2

; Expected output:
; BX=0016h
; CX=FFFEh
; sum: 16h 00h
