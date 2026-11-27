; The table of squares generated at assembly time is read with XLAT: 5^2 + 7^2 = 25 + 49 = 74 (4Ah).
; The slide gives the table in its expanded form (a DB line); the version generated with REPT
; is in rept_squares_source.asm. Slides 9.1 "A Table with REPT: Code Trace".
org 100h
lea  bx, sq
mov  al, 5
xlat           ; AL = sq[5]
mov  dl, al
mov  al, 7
xlat           ; AL = sq[7]
add  al, dl
ret
sq db 0, 1, 4, 9, 16, 25, 36, 49

; As on the slide, LEA BX, sq: BX = 010Eh.
; REGISTERS: AL BX DL

; Expected output:
; AL=4Ah
; BX=010Eh
; DL=19h
