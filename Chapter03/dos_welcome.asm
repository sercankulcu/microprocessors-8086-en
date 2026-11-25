; x86 Assembly (DOS): INT 21h / 09h prints a '$'-terminated string, 4Ch ends the program.
; Source: Chapter 3.1 Programming Languages, "x86 Assembly (DOS)"

org 100h          ; COM program
mov ah, 09h       ; DOS 09h: print string
lea dx, msg       ; DS:DX = address
int 21h           ; call DOS
mov ax, 4C00h     ; DOS 4Ch: exit
int 21h
msg db 'Welcome, DOS!$'

; Expected output:
; Welcome, DOS!
