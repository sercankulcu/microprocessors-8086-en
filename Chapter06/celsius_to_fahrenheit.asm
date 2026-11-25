; C -> F: f = c x 9 / 5 + 32, with IMUL and IDIV. 15 C = 59 F (AX = 003Bh).
; Source: Chapter 6 slides, "Celsius to Fahrenheit".
; REGISTERS: AX CX
org 100h
start:
;celsius to fahrenheit according to f = c * 9 / 5 + 32
mov cl, 15
mov al, 9
imul cl
mov cl, 5
idiv cl
add al, 32
ret

; Expected output:
; AX=003Bh
; CX=0005h
