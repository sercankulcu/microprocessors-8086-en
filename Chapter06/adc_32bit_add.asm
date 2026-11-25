; 32-bit addition with ADC: 0001FFFFh + 00020001h = 00040000h (DX:AX).
; Source: Chapter 6 slides, "Multiword Addition with ADC".
; REGISTERS: DX AX CF
org 100h        ; not in the slides: .COM program
; DX:AX = 0001FFFFh, CX:BX = 00020001h
mov ax, 0FFFFh
mov dx, 0001h
mov bx, 0001h
mov cx, 0002h
add ax, bx      ; low words
adc dx, cx      ; high + CF
ret             ; not in the slides: end the program

; Expected output:
; DX=0004h
; AX=0000h
; CF=0
