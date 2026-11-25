; Writing a string with INT 10h AH = 13h: the string is at ES:BP, AL = 01h moves the cursor to the end of the string.
; Source: Chapter 5.2 slides, "AH = 13h: Write String".
; REGISTERS: BP
org 100h
mov ax, 1301h    ; AH=13h, AL=01h
mov bx, 001Eh    ; BH=0, BL=1Eh
mov cx, 7        ; string length
mov dx, 0205h    ; row 2, column 5
lea bp, msg      ; ES:BP -> string
int 10h
ret
msg db 'Welcome'

; Expected output:
;
;
;      Welcome
; BP=0112h
