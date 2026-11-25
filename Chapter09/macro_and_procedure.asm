; Macro and procedure together: PUT_DIGIT MACRO d / mov al, d / call print_digit / ENDM.
; The macro puts the parameter in a register, the shared work is one copy in the procedure.
; The code below is the expansion of the two calls (PUT_DIGIT 4, PUT_DIGIT 7).
; Slides 9.1 "Macro and Procedure Together: Code Trace".
org 100h
mov  al, 4       ; PUT_DIGIT 4
call print_digit
mov  al, 7       ; PUT_DIGIT 7
call print_digit
ret
print_digit:
add  al, '0'     ; digit → ASCII
mov  ah, 0Eh
int  10h
ret

; REGISTERS: AL

; Expected output:
; 47
; AL=37h
