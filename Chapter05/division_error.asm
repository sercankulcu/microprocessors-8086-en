; Installing our own INT 0 (divide error) routine: DIV BL with BL = 0 raises INT 0,
; the routine leaves the marker AX = FFFFh, and IRET returns to the instruction after DIV.
; Source: Chapter 5.1 slides, "Divide Error: Code Trace".
; On the 8086 (and in emu8086) INT 0 pushes the address of the instruction after DIV
; (the 80286 and later push the address of the DIV itself); result: AX = FFFFh, DL = FFh.
; REGISTERS: AX DL
org 100h
mov ax, 0
mov es, ax           ; ES = 0: IVT
mov word ptr es:[0*4], offset div_err
mov word ptr es:[0*4+2], cs
mov ax, 100
mov bl, 0
div bl               ; INT 0!
mov dl, al           ; execution resumes here
ret
div_err:
mov ax, 0FFFFh       ; error marker
iret

; Expected output:
; AX=FFFFh
; DL=FFh
