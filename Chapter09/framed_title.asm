; Framed title: CLEAR_SCREEN, GOTOXY and PRINT come from the library, the line is our own
; procedure. The PUTC '-' in the loop is expanded once and runs 10 times.
; Slides 9.2 "Example: Framed Title".
include 'emu8086.inc'
ORG  100h
CALL clear_screen
GOTOXY 10, 2
CALL hline
GOTOXY 10, 3
PRINT '|  HEADER  |'
GOTOXY 10, 4
CALL hline
GOTOXY 0, 6       ; cursor below
RET
hline PROC        ; +----------+
PUTC '+'
MOV  CX, 10
dash: PUTC '-'
LOOP dash
PUTC '+'
RET
hline ENDP
DEFINE_CLEAR_SCREEN
END

; Expected output:
;
;
;           +----------+
;           |  HEADER  |
;           +----------+
