; Nested loops: the outer counter is saved with PUSH/POP. Prints "122222" 5 times, BX = 30.
; Slides: Chapter 7 Flow Control, slide "Nested Loops".
option nokeyword:<k1 k2> ; not in the slides: UASM takes k1/k2 for AVX-512 registers
org 100h
mov bx, 0      ; total steps
mov cx, 5      ; outer loop counter
k1:
 add bx, 1
 mov al, '1'
 mov ah, 0eh
 int 10h       ; print '1'
 push cx       ; save the outer counter
 mov cx, 5     ; inner loop counter
k2:
  add bx, 1
  mov al, '2'
  mov ah, 0eh
  int 10h      ; print '2'
  loop k2      ; inner loop
 pop cx        ; restore the outer counter
loop k1        ; outer loop
ret

; REGISTERS: BX CX

; Expected output:
; 122222122222122222122222122222
; BX=001Eh
; CX=0000h
