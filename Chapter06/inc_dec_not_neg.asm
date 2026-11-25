; INC and DEC do not change CF; 7Fh + 1 is a signed overflow (OF = 1); NOT changes no flag;
; NEG of the complement 7Fh gives 81h (-127), CF = 1.
; Source: Chapter 6 slides, "Code Trace: INC, DEC, NOT, NEG".
; REGISTERS: AL BL CF SF OF
org 100h        ; not in the slides: .COM program
mov al, 0FFh
inc al          ; FFh + 1
dec al          ; 00h - 1
mov bl, 7Fh     ; +127
inc bl          ; +128 ?
not bl
neg bl
ret             ; not in the slides: end the program

; Expected output:
; AL=FFh
; BL=81h
; CF=1
; SF=1
; OF=0
