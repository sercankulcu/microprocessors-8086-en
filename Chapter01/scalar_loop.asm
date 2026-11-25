; Scalar processor, c = a + b: a separate read, add, write and loop overhead for each element.
; c = 13, 25, 37, 49; 22 instructions are executed for 4 additions.
; Source: Chapter 1.1 Introduction, "Scalar Loop: Code Trace"

option nokeyword:<c>  ; not in the slides: in MASM/UASM C is a reserved word (language type); in emu8086 it is not
org 100h
mov si, 0
mov cx, 4
again: mov al, a[si]  ; read one item
add al, b[si]         ; one add
mov c[si], al         ; write one item
inc si
loop again
ret
a db 3, 5, 7, 9
b db 10, 20, 30, 40
c db 4 dup(0)

; REGISTERS: SI
; MEMORY: c 4

; Expected output:
; SI=0004h
; c: 0Dh 19h 25h 31h
