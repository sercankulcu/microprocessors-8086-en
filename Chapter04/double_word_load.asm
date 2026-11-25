; Loading a 32-bit variable into DX:AX: word ptr data (low) and word ptr [data+2] (high).
; Slides 4.2 Variables, slide "Code Trace: A 32-Bit Load into DX:AX".
ORG 100h        ; not in the slides
mov ax, word ptr data      ; data+0
mov dx, word ptr [data+2]  ; data+2
ret
data dd 12345678h

; REGISTERS: DX AX

; Expected output:
; DX=1234h
; AX=5678h
