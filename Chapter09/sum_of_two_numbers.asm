; Sum of two numbers: the first number is saved in BX, the second is written to CX by SCAN_NUM;
; if the signed sum overflows (JO) '?' is written. Input 120 and -45 -> 75 (the slide's table:
; -7, -8 -> -15; 30000, 5000 -> ?). Slides 9.2 "Example: Sum of Two Numbers".
include 'emu8086.inc'
ORG  100h
CALL scan_num     ; 1st number → CX
MOV  BX, CX       ; save it
PUTC 13
PUTC 10           ; next line
CALL scan_num     ; 2nd number → CX
PUTC 13
PUTC 10
MOV  AX, BX
ADD  AX, CX       ; signed sum
JO   overflow
CALL print_num
RET
overflow: PUTC '?'
RET
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
END

; INPUT: "120\r-45\r"

; Expected output:
; 120
; -45
; 75
