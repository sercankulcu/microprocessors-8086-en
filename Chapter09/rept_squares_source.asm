; The same table of squares is generated at assembly time with REPT (the slide note's "Source of the
; table": n = 0 / sq LABEL BYTE / REPT 8 / DB n*n / n = n + 1 / ENDM). A symbol defined
; with = takes a new value each round. Slides 9.1 "A Table with REPT: Code Trace".
org 100h
lea  bx, sq
mov  al, 5
xlat           ; AL = sq[5]
mov  dl, al
mov  al, 7
xlat           ; AL = sq[7]
add  al, dl
ret
n = 0
sq LABEL BYTE
REPT 8
  DB n*n
  n = n + 1
ENDM

; REGISTERS: AL DL
; MEMORY: sq 8

; Expected output:
; AL=4Ah
; DL=19h
; sq: 00h 01h 04h 09h 10h 19h 24h 31h
