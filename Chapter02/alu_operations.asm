; ALU operations: addition, 8-bit subtraction, MUL, DIV, AND mask, and clearing with XOR.
; AX: 0040h -> 003Bh -> 00ECh -> 004Eh (remainder DX = 2) -> 000Eh -> 0000h
; Source: Chapter 2.1 8086 Architecture, "ALU Operations: Code Trace"

org 100h
mov ax, 0010h
mov bx, 0030h
add ax, bx      ; AX ← AX + BX
sub al, 5       ; AL ← AL − 5
mov bl, 4
mul bl          ; AX ← AL × BL
mov dx, 0
mov cx, 3
div cx          ; AX ← DX:AX ÷ CX
and al, 0Fh     ; clear upper 4 bits
xor ax, ax      ; AX ← 0
ret

; REGISTERS: AX BX CX DX CF ZF

; Expected output:
; AX=0000h
; BX=0004h
; CX=0003h
; DX=0002h
; CF=0
; ZF=1
