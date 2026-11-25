; Preparing for division: for unsigned, DX is cleared (1000 / 7 = 142, remainder 6); for
; signed, CWD sign-extends (-1000 / 7 = -142, remainder -6). The unsigned result is not
; saved anywhere; the final registers are those of the signed division.
; Source: Chapter 6 slides, "Preparing for Division: CBW, CWD".
; REGISTERS: AX DX
org 100h        ; not in the slides: .COM program
; unsigned: 1000 / 7
mov ax, 1000
xor dx, dx      ; DX:AX = 1000
mov bx, 7
div bx          ; AX = 142, DX = 6

; signed: -1000 / 7
mov ax, -1000
cwd             ; DX = FFFFh
idiv bx         ; AX = -142, DX = -6
ret             ; not in the slides: end the program

; Expected output:
; AX=FF72h
; DX=FFFAh
