; Return by flag: the digit procedure converts the character in AL to a number and reports success in CF.
; '7' -> CF = 0, AL = 7 (saved in BL); 'x' -> CF = 1 (not a digit).
; Slides: Chapter 8 Procedures, slide "Return by Flag: Code Trace".
ORG  100h        ; not in the slides: .COM program
MOV  AL, '7'
CALL digit       ; CF = 0 -> AL = value
MOV  BL, AL
MOV  AL, 'x'
CALL digit       ; CF = 1 -> not a digit
RET
digit PROC       ; In: AL, Out: CF
SUB  AL, '0'
CMP  AL, 10      ; 0..9 -> borrow, CF = 1
CMC              ; if a digit, CF = 0
RET
digit ENDP

; REGISTERS: AL BL CF
; Expected output:
; AL=48h
; BL=07h
; CF=1
