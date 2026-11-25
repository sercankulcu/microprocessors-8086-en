; Mini menu: print the menu with AH = 09h, read the choice with AH = 01h; '1' prints a greeting, 'q' quits
; (INT 21h AH = 4Ch, exit code 0). As in the slides: first 1, then q.
; Source: Chapter 5.2 slides, "Trace: Mini Menu".
; INPUT: "1q"
org 100h
show:
mov dx, offset menu
mov ah, 09h
int 21h
mov ah, 01h       ; read the choice
int 21h
cmp al, 'q'
je quit
cmp al, '1'
jne show
mov dx, offset greet
mov ah, 09h
int 21h
jmp show
quit:
mov ax, 4C00h     ; exit code 0
int 21h
menu  db 0Dh, 0Ah, '1:Hello q:Leave $'
greet db 0Dh, 0Ah, 'Hello!$'

; Expected output:
;
; 1:Hello q:Leave 1
; Hello!
; 1:Hello q:Leave q
