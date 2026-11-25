; Print a byte in hexadecimal with XLAT: the high nibble (SHR AL, CL; on the 8086 a shift count
; greater than 1 goes in CL) and the low nibble (AND AL, 0Fh) are turned into characters via hex_tab[].
; 3Ch -> "3C".
; Source: Chapter 11 Instruction Encoding and String Instructions, "Trace: XLAT"
; REGISTERS: BX

org 100h
mov bx, offset hex_tab
mov al, num        ; AL = 3Ch
mov cl, 4
shr al, cl         ; high nibble
xlat               ; AL = [BX+AL]
mov dl, al
mov ah, 2
int 21h            ; print DL
mov al, num
and al, 0Fh        ; low nibble
xlat
mov dl, al
int 21h
ret
num     db 3Ch
hex_tab db '0123456789ABCDEF'

; Expected output:
; 3C
; BX=011Dh
