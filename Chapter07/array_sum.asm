; Summing array elements with LOOP: 5 + 4 + 5 + 2 + 1 = 17 = 11h, the result is in m.
; Slides: Chapter 7 Flow Control, slide "Sum of Array Elements".
org 100h
mov cx, 5           ; element count
mov al, 0           ; sum (AL) = 0
mov bx, 0           ; BX = index
next:
add al, vector[bx]  ; add the element
inc bx              ; next element
loop next           ; repeat until CX = 0
mov m, al           ; store the result in m
ret
vector db 5, 4, 5, 2, 1
m db 0

; REGISTERS: AL BX
; MEMORY: m 1

; Expected output:
; AL=11h
; BX=0005h
; m: 11h
