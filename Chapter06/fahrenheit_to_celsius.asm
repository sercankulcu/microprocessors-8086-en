; F -> C: c = (f - 32) x 5 / 9, with IMUL and IDIV. 59 F = 15 C (AL = 0Fh, remainder AH = 0).
; Source: Chapter 6 slides, "Fahrenheit to Celsius".
; REGISTERS: AX
org 100h
start:
;fahrenheit to celsius according to: c = (f - 32) * 5 / 9
mov cl, 59
sub cl, 32
mov al, 5
imul cl
mov cl, 9
idiv cl
ret

; Expected output:
; AX=000Fh
