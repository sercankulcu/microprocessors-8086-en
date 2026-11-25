; The expansion of PUTC 'A' and PUTC 'B': 2 copies x 8 bytes + RET = 17 bytes; AX is not damaged.
; Slides 9.1 "PUTC Running".
ORG  100h
push ax          ; PUTC 'A'
mov  al, 'A'
mov  ah, 0eh
int  10h
pop  ax
push ax          ; PUTC 'B'
mov  al, 'B'
mov  ah, 0eh
int  10h
pop  ax
RET

; REGISTERS: AX

; Expected output:
; AB
; AX=0000h
