; AAD: convert unpacked "54" to binary (36h) before dividing, then 54 / 6 = 9.
; Source: Chapter 6 slides, "AAM and AAD" (second example).
; REGISTERS: AX
org 100h       ; not in the slides: .COM program
mov ax, 0504h  ; '54' unpacked
aad            ; AX = 0036h (54)
mov bl, 6
div bl         ; AL = 09h, AH = 00h
ret            ; not in the slides: end the program

; Expected output:
; AX=0009h
