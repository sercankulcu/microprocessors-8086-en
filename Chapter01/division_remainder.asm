; Division-remainder method: 2989 is divided by 16 repeatedly, the remainders go into an array.
; The remainders are 0D 0A 0B; read from last to first they give 0BADh = 2989.
; Source: Chapter 1.2 Number Systems, "Division-Remainder: Code Trace"

ORG 100h
MOV AX, 2989   ; number
MOV BX, 16     ; base
MOV SI, 0      ; counter
again: MOV DX, 0 ; DX:AX
DIV BX         ; quot, rem
MOV rem[SI], DL
INC SI
CMP AX, 0      ; quotient 0?
JNE again
RET
rem DB 4 DUP(0)

; REGISTERS: AX DX SI
; MEMORY: rem 4

; Expected output:
; AX=0000h
; DX=000Bh
; SI=0003h
; rem: 0Dh 0Ah 0Bh 00h
