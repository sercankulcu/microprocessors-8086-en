; The expansion of PRINT2 'O', 'K': at level 1 two PUTCs, at level 2 the bodies of the PUTCs.
; Both levels do the same job; here they run one after the other, so OK is written twice.
; Slides 9.1 "Nested Macros" (expansion slides).
include 'emu8086.inc'    ; not on the slide: the level-1 PUTC definition
ORG 100h                 ; not on the slide
; level 1: PRINT2 expands
PUTC 'O'
PUTC 'K'
; level 2: the PUTCs expand
push ax
mov  al, 'O'
mov  ah, 0eh
int  10h
pop  ax
push ax
mov  al, 'K'
mov  ah, 0eh
int  10h
pop  ax
RET                      ; not on the slide

; Expected output:
; OKOK
