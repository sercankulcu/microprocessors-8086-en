; Read and print a number: the question with PRINT_STRING, the number with SCAN_NUM (CX), the message
; with PTHIS, the signed result with PRINT_NUM. Input -25 -> CX = FFE7h.
; Slides 9.2 "Example: Read and Print a Number".
include 'emu8086.inc'
ORG    100h
LEA    SI, msg1       ; ask for the number
CALL   print_string   ;
CALL   scan_num       ; get number in CX.
MOV    AX, CX         ; copy the number to AX.
CALL   pthis          ; print the following string:
DB  13, 10, 'You have entered: ', 0
CALL   print_num      ; print number in AX.
RET                   ; return to operating system.
msg1   DB  'Enter the number: ', 0
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS  ; required for print_num.
DEFINE_PTHIS
END                   ; directive to stop the compiler.

; INPUT: "-25\r"
; REGISTERS: CX

; Expected output:
; Enter the number: -25
; You have entered: -25
; CX=FFE7h
