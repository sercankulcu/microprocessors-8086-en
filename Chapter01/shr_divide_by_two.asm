; Dividing by 2 with SHR: SHR gives the quotient, the bit shifted out (the remainder) goes to CF;
; RCR shifts the remainder into BL from the left. After 8 passes BL = 0010 1101b = 2Dh = 45.
; Source: Chapter 1.2 Number Systems, "Dividing by 2 with SHR: Code Trace"

ORG 100h
MOV AL, 45     ; dividend
MOV CX, 8      ; 8 bits
bit: SHR AL, 1 ; rem → CF
RCR BL, 1      ; CF → BL
LOOP bit
RET

; REGISTERS: AL BL CX

; Expected output:
; AL=00h
; BL=2Dh
; CX=0000h
