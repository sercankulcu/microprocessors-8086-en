; 32-bit subtraction with SBB: 00040000h - 00010001h = 0002FFFFh (DX:AX).
; Source: Chapter 6 slides, "32-Bit Subtraction with SBB".
; REGISTERS: DX AX CF
org 100h        ; not in the slides: .COM program
; DX:AX = 00040000h, CX:BX = 00010001h
mov ax, 0000h
mov dx, 0004h
mov bx, 0001h
mov cx, 0001h
sub ax, bx      ; low words
sbb dx, cx      ; high - CF
ret             ; not in the slides: end the program

; Expected output:
; DX=0002h
; AX=FFFFh
; CF=0
