; PRINTN writes and moves to the next line; CURSOROFF / CURSORON hide / show the cursor
; (INT 10h, AH = 01h). Slides 9.2 "PRINTN and the Cursor Macros".
include 'emu8086.inc'    ; not on the slide
ORG 100h                 ; not on the slide
PRINTN 'Full name:'   ; print, then newline
CURSOROFF
GOTOXY 30, 12
PRINT 'Hello'
CURSORON
RET                      ; not on the slide

; Expected output:
; Full name:
;
;
;
;
;
;
;
;
;
;
;
;                               Hello
