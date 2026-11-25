; Nested macros: PRINT2 uses PUTC in its body; a one-line call produces 10 instructions.
; Slides 9.1 "Nested Macros".
include 'emu8086.inc'    ; not on the slide: the PUTC definition

PRINT2 MACRO c1, c2
       PUTC c1
       PUTC c2
ENDM

ORG 100h                 ; not on the slide
PRINT2 'O', 'K'
RET                      ; not on the slide

; Expected output:
; OK
