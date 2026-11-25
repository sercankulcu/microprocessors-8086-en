; Using a procedure: the DEFINE_... macro lays the procedure out between RET and END, the code
; uses it with CALL. Same bits: FFE7h = -25 (signed) = 65 511 (unsigned).
; Slides 9.2 "Using a Procedure: DEFINE_ and CALL" (an example replaces the "..." on the
; slide; the value is from the "Number Procedures" slide).
include 'emu8086.inc'
ORG 100h
    MOV  AX, -25         ; not on the slide
    CALL print_num   ; use
    PUTC ' '             ; not on the slide
    CALL print_num_uns   ; not on the slide
RET

DEFINE_PRINT_NUM    ; define
DEFINE_PRINT_NUM_UNS
END

; Expected output:
; -25 65511
