; Multiply-accumulate (MAC): y = 2*10 + 3*20 + 1*30 = 110. A separate MUL and ADD for each
; term; a DSP does this with a single MAC instruction.
; Source: Chapter 1.1 Introduction, "Multiply-Accumulate (MAC): Code Trace"

org 100h
mov si, 0
mov bx, 0        ; sum
mov cx, 3        ; term count
again: mov al, h[si]
mul x[si]        ; AX = h × x
add bx, ax       ; accumulate
inc si
loop again
ret
h db 2, 3, 1
x db 10, 20, 30

; REGISTERS: BX AX

; Expected output:
; BX=006Eh
; AX=001Eh
