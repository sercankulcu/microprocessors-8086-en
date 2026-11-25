; Finding the larger of two variables (CMP + JGE, signed): value1 = 10, value2 = 5.
; Slides 4.2 Variables, slide "Code Trace: Find the Larger (10, 5)".
ORG 100h
MOV AX, value1     ; AX <- value1
CMP AX, value2     ; AX - value2
JGE greater_or_equal
MOV AX, value2     ; if less, value2
JMP store_max
greater_or_equal:
MOV AX, value1
store_max:
MOV max_value, AX  ; store the result
RET
value1 DW 10
value2 DW 5
max_value DW ?

; REGISTERS: AX CF ZF SF OF
; MEMORY: max_value 2

; Expected output:
; AX=000Ah
; CF=0
; ZF=0
; SF=0
; OF=0
; max_value: 0Ah 00h
