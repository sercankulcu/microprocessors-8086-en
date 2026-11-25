; DD, two DWs, four DBs and a binary DD produce the same four bytes (78 56 34 12); loading into DX:AX.
; Slides 4.2 Variables, slide "Doubleword Variables".
org 100h
jmp start
mydouble dd 12345678h  ; double word
mywords  dw 5678h      ; 2 separate words
         dw 1234h
mybytes  db 78h        ; 4 separate bytes
         db 56h
         db 34h
         db 12h
data dd 00010010001101000101011001111000b
start:  ; load data into DX:AX
mov ax, word ptr data
mov dx, word ptr [data+2]
ret

; REGISTERS: DX AX
; MEMORY: mydouble 4
; MEMORY: mywords 4
; MEMORY: mybytes 4
; MEMORY: data 4

; Expected output:
; DX=1234h
; AX=5678h
; mydouble: 78h 56h 34h 12h
; mywords: 78h 56h 34h 12h
; mybytes: 78h 56h 34h 12h
; data: 78h 56h 34h 12h
