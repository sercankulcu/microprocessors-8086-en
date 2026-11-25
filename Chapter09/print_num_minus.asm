; PRINT_NUM and the minus sign: OR AX, AX puts the sign bit in SF; if negative, NEG takes the
; absolute value and '-' is written first. AX is FFE7h again after printing.
; Slides 9.2 "PRINT_NUM and the Minus Sign: Code Trace".
include 'emu8086.inc'    ; not on the slide: for print_num_uns
ORG  100h
MOV  AX, -25       ; AX = FFE7h
CALL print_num
RET
print_num PROC
PUSH AX
OR   AX, AX        ; SF = sign bit
JNS  positive
NEG  AX            ; AX = 0019h
PUSH AX            ; PUTC '-' expansion
MOV  AL, '-'
MOV  AH, 0Eh
INT  10h
POP  AX
positive: CALL print_num_uns
POP  AX            ; AX = FFE7h again
RET
print_num ENDP
DEFINE_PRINT_NUM_UNS     ; not on the slide: the called procedure comes from the library

; REGISTERS: AX

; Expected output:
; -25
; AX=FFE7h
