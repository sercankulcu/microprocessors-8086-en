; Macro library: GOTOXY, PRINT, PUTC from emu8086.inc are used through include.
; Slides 9.1 "Macro Libraries".
include 'emu8086.inc'
ORG 100h
    GOTOXY 10, 5
    PRINT 'Hello'
    PUTC  '!'
    RET

; Expected output:
;
;
;
;
;
;           Hello!
