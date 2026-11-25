; The service-call pattern: AH = service number, other registers = parameters, then INT.
; Source: Chapter 5.2 slides, "Service Call Pattern".
org 100h       ; not in the slides: a .COM program
mov ah, 02h    ; service: write character
mov dl, 'A'    ; parameter
int 21h        ; call DOS
ret            ; not in the slides: end the program

; Expected output:
; A
