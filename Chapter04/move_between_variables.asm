; Moving from one variable to another goes through a register; jmp start skips the data.
; Slides 4.2 Variables, slide "Code Trace: Moving Data Between Variables".
ORG 100h
jmp start
value1 DW 10    ; a 2-byte variable
value2 DW 0     ; a second one
start:
MOV AX, value1  ; AX <- value1
MOV value2, AX  ; value2 <- AX
RET
end start

; REGISTERS: AX
; MEMORY: value2 2

; Expected output:
; AX=000Ah
; value2: 0Ah 00h
