; The expansion of POWER base, exponent, result (code is 19 bytes: base 0113h, exponent 0115h,
; result 0117h). Slides 9.1 "POWER Running".
ORG 100h
mov ax, 1        ; POWER expansion
mov cx, exponent
mov bx, base
powerloop:
mul bx
loop powerloop
mov result, ax
ret
base     dw 2    ; 0113h
exponent dw 3    ; 0115h
result   dw ?    ; 0117h

; REGISTERS: AX BX CX DX CF OF
; MEMORY: result 2

; Expected output:
; AX=0008h
; BX=0002h
; CX=0000h
; DX=0000h
; CF=0
; OF=0
; result: 08h 00h
