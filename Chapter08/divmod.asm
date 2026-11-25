; Multiple results: divmod divides AX by BL; AL = quotient, AH = remainder, CF = 1 if the divisor is 0.
; 100 / 7 -> AL = 0Eh, AH = 02h, CF = 0 (saved in DX); 100 / 0 -> CF = 1, AX unchanged.
; (A third input, 1000 / 2, would cause a divide error because the quotient does not fit in AL; not tried here.)
; Slides: Chapter 8 Procedures, slide "Returning Multiple Results".
ORG  100h       ; not in the slides: .COM program
MOV  AX, 100    ; not in the slides: 1st try
MOV  BL, 7      ; not in the slides
CALL divmod     ; not in the slides
MOV  DX, AX     ; not in the slides: save the result
MOV  AX, 100    ; not in the slides: 2nd try, divisor 0
MOV  BL, 0      ; not in the slides
CALL divmod     ; not in the slides
RET             ; not in the slides: return to DOS
divmod PROC     ; In: AX, BL (divisor)
CMP  BL, 0      ; Out: AL = quotient
JE   error      ;      AH = remainder
DIV  BL         ;      CF = 1: divisor is 0
CLC
RET
error: STC
RET
divmod ENDP

; REGISTERS: DX AX CF
; Expected output:
; DX=020Eh
; AX=0064h
; CF=1
