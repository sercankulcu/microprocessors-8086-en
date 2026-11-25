; Multiplication and division with shifts: AX x 3 = AX x 2 + AX; unsigned / 8 (SHR) and
; remainder (AND 7); signed / 4 (SAR, rounds toward minus infinity: -7 -> -2). The three
; parts in the slides are independent; the starting values (AX = 5 and AX = -7) are not in
; the slides.
; Source: Chapter 6 slides, "Multiplication and Division with Shifts".
; REGISTERS: AX BX DX SI
org 100h       ; not in the slides: .COM program
mov ax, 5      ; not in the slides: example value
; AX <- AX x 3 = AX*2 + AX
mov bx, ax     ; save
shl ax, 1      ; AX x 2
add ax, bx     ; x2 + x1

; unsigned / 8 and remainder
mov dx, ax
and dx, 0007h  ; remainder = low 3 bits
mov cl, 3
shr ax, cl     ; quotient
mov si, ax     ; not in the slides: save the 15 / 8 quotient

; signed / 4
mov ax, -7     ; not in the slides: example value
mov cl, 2
sar ax, cl     ; -7 -> -2
ret            ; not in the slides: end the program

; Expected output:
; AX=FFFEh
; BX=0005h
; DX=0007h
; SI=0001h
