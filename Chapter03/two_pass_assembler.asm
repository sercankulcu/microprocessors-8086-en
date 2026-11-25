; The assembler's two passes: in pass 1, msg = 010Ch enters the symbol table; in pass 2
; the bytes are generated: B4 09 BA 0C 01 CD 21 B8 00 4C CD 21 followed by the string.
; The 21-byte COM file prints Welcome! on the screen.
; Source: Chapter 3.1 Programming Languages, "The Assembler's Two Passes: Step by Step"
; (the same code also appears in the listing table of the "Translating and Linking" slide)

code EQU 0100h    ; not in the slide: start of the code, for the MEMORY directive

org 100h
mov ah, 09h
mov dx, offset msg
int 21h
mov ax, 4C00h
int 21h
msg db 'Welcome!$'

; MEMORY: code 21

; Expected output:
; Welcome!
; code: B4h 09h BAh 0Ch 01h CDh 21h B8h 00h 4Ch CDh 21h 57h 65h 6Ch 63h 6Fh 6Dh 65h 21h 24h
