; PUSH and POP in the same order: the top (CX) goes to AX; the bottom (AX) goes to CX. AX and CX swap places.
; Slides: Chapter 8 The Stack, slide "Using the Stack" (loaded as .BIN in the slides; here .COM).
org 100h          ; not in the slides: .COM program
mov ax, 2
mov bx, 4
mov cx, 8
push ax
push bx
push cx
pop  ax
pop  bx
pop  cx
ret               ; not in the slides: return to DOS

; REGISTERS: AX BX CX
; Expected output:
; AX=0008h
; BX=0004h
; CX=0002h
