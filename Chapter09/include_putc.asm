; Source after INCLUDE: the include line is replaced by the library text; the macro definitions
; are only templates (0 bytes), code appears where PUTC 'A' is used (8 bytes).
; Slides 9.2 "Source After INCLUDE" (the include line stands in for the "..." templates
; on the slide).
include 'emu8086.inc'    ; not on the slide: the slide shows the text that replaces this line
; the program itself:
ORG  100h
PUTC 'A'            ; 8 bytes here
RET

; Expected output:
; A
