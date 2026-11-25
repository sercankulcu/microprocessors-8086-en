; AAM: split AL into two unpacked digits after multiplication. 7 x 8 = 56 -> AH = 5, AL = 6.
; Source: Chapter 6 slides, "AAM and AAD" (first example).
; REGISTERS: AX
org 100h    ; not in the slides: .COM program
mov al, 7
mov bl, 8
mul bl      ; AX = 0038h (56)
aam         ; AH = 05h, AL = 06h
ret         ; not in the slides: end the program

; Expected output:
; AX=0506h
