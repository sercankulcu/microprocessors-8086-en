; Two's complement: NOT + 1 and NEG give the same result (-45 = D3h), -45 + 45 = 0;
; in 16 bits -45 = FFD3h.
; Source: Chapter 1.2 Number Systems, "Two's Complement: Code Trace"

ORG 100h
MOV AL, 45       ; +45
MOV BL, AL
NOT BL         ; ones' comp.
INC BL           ; + 1
NEG AL           ; one instr.
CMP AL, BL       ; equal?
ADD AL, 45       ; -45 + 45
MOV AX, 45
NEG AX           ; -45 in 16 bits
RET

; REGISTERS: AX BL CF ZF SF OF

; Expected output:
; AX=FFD3h
; BL=D3h
; CF=1
; ZF=0
; SF=1
; OF=0
