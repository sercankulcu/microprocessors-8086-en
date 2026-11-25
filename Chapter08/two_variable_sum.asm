; Parameters as memory variables: AddNumbers writes number1 + number2 = 8 into result.
; Slides: Chapter 8 Procedures, slide "Adding Two Variables".
ORG 100h
start:
CALL AddNumbers    ; call the procedure
RET                ; back to DOS
AddNumbers PROC
MOV AX, number1    ; AX = first number
ADD AX, number2    ; AX = AX + second number
MOV result, AX     ; store the result
RET                ; end of procedure
AddNumbers ENDP
number1 DW 5       ; first number is 5
number2 DW 3       ; second number is 3
result  DW ?       ; holds the result

; REGISTERS: AX
; MEMORY: result 2
; Expected output:
; AX=0008h
; result: 08h 00h
