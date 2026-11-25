; Screen with macros: PRINT, GOTOXY and PUTC (a number or a character constant).
; Slides 9.2 "Example: Screen with Macros" (and "Code Trace: PRINT, GOTOXY, PUTC").
include emu8086.inc
ORG    100h
PRINT 'Hello World!'
GOTOXY 10, 5
PUTC 65           ; 65 - is an ASCII code for 'A'
PUTC 'B'
RET               ; return to operating system.
END               ; directive to stop the compiler.

; Expected output:
; Hello World!
;
;
;
;
;           AB
