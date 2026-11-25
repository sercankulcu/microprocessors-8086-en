; x 10 (= x 8 + x 2) and / 16 (SHR 4, remainder AND 0Fh) with shifts: 37 x 10 = 370 = 0172h,
; 370 / 16 = 23 (0017h) remainder 2. On the 8086 the shift count is 1 or CL.
; Source: Chapter 6 slides, "x10 and /16 with Shifts: Code Trace".
; REGISTERS: AX BX
org 100h
mov ax, 37
shl ax, 1      ; AX x 2
mov bx, ax     ; save
shl ax, 1      ; AX x 4
shl ax, 1      ; AX x 8
add ax, bx     ; x8 + x2
mov bx, ax
and bx, 000Fh  ; remainder: low 4 bits
mov cl, 4
shr ax, cl     ; quotient: / 16
ret

; Expected output:
; AX=0017h
; BX=0002h
