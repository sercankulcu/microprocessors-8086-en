; Clearing the screen to a blue background with INT 10h AH = 06h (AL = 0) and opening a centered
; 10 x 40 red box. The colors (attributes) are not visible in the test output.
; Source: Chapter 5.2 slides, "AH = 06h: Clear Screen" and "Window with AH = 06h: Code Trace".
; REGISTERS: AX BH CX DX
org 100h
mov ax, 0600h   ; AH=06h, AL=0
mov bh, 1Fh     ; blue/white
mov cx, 0000h   ; (0,0)
mov dx, 184Fh   ; (24,79)
int 10h
mov ax, 0600h
mov bh, 4Fh     ; red/white
mov cx, 0714h   ; (7,20)
mov dx, 103Bh   ; (16,59)
int 10h
ret

; Expected output:
; AX=0600h
; BH=4Fh
; CX=0714h
; DX=103Bh
