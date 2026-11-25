; Printing '$'-terminated strings with INT 21h AH = 09h; AH is still 09h on the second call.
; Source: Chapter 5.2 slides, "Trace: AH = 09h".
org 100h
mov dx, offset msg1   ; DS:DX -> string
mov ah, 09h
int 21h
mov dx, offset msg2
int 21h               ; AH is still 09h
ret
msg1 db 'Welcome, 8086!', 0Dh, 0Ah, '$'
msg2 db 'Good-bye!$'

; Expected output:
; Welcome, 8086!
; Good-bye!
