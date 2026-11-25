; The same program, the other branch: value1 = 3, value2 = 7 -> JGE does not jump, the larger one is value2.
; Slides 4.2 Variables, slide "Code Trace: Find the Larger (3, 7)".
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
value1 DW 3
value2 DW 7
max_value DW ?

; REGISTERS: AX CF ZF SF OF
; MEMORY: max_value 2

; Expected output:
; AX=0007h
; CF=1
; ZF=0
; SF=1
; OF=0
; max_value: 07h 00h
