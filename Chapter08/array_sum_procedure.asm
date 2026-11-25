; Array sum procedure: the address is given in SI, the count in CX; the total returns in AL (17 = 11h).
; Slides: Chapter 8 Procedures, slide "Array Sum Procedure".
ORG  100h
LEA  SI, vector     ; parameter 1: address
MOV  CX, 5          ; parameter 2: count
CALL sum
MOV  m, AL          ; return value in AL
RET
sum PROC            ; In: SI, CX
MOV  AL, 0          ; Out: AL = sum
again:
ADD  AL, [SI]
INC  SI
LOOP again
RET
sum ENDP
vector DB 5, 4, 5, 2, 1
m      DB 0

; REGISTERS: AL CX
; MEMORY: m 1
; Expected output:
; AL=11h
; CX=0000h
; m: 11h
