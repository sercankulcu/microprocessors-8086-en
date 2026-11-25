; The expansion of the fixed POWER base, expn, res: 7^2 = 49 (0031h); the macro changes only AX.
; Slides 9.1 "Fixed POWER: Code Trace".
org 100h
mov  bx, 0AAAh   ; not on the slide: the slide's initial values
mov  cx, 0BBBh   ; not on the slide
mov  dx, 0CCCh   ; not on the slide
push bx          ; POWER expansion
push cx
push dx
mov  ax, 1
mov  cx, expn
mov  bx, base
jcxz ??0001      ; expn = 0 → 1
??0000: mul bx
loop ??0000
??0001: mov res, ax
pop  dx
pop  cx
pop  bx
ret
base dw 7
expn dw 2
res  dw ?

; REGISTERS: AX BX CX DX
; MEMORY: res 2

; Expected output:
; AX=0031h
; BX=0AAAh
; CX=0BBBh
; DX=0CCCh
; res: 31h 00h
