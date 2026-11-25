; Adding two word variables and storing the sum in a third: 105h + 103h = 208h.
; Slides 4.2 Variables, slide "Code Trace: Adding Variables".
ORG 100h
jmp start
value1 DW 105h  ; initially 105h
value2 DW 103h  ; initially 103h
result DW ?     ; undefined
start:
MOV AX, value1  ; AX <- value1
ADD AX, value2  ; AX <- AX + value2
MOV result, AX  ; result <- AX
RET
end start

; REGISTERS: AX CF ZF PF
; MEMORY: result 2

; Expected output:
; AX=0208h
; CF=0
; ZF=0
; PF=0
; result: 08h 02h
