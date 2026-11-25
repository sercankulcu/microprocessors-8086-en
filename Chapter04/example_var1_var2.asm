; Variable names are replaced by offsets: MOV AL, var1 -> MOV AL, [0108h]; names are case-insensitive
; (VAR1 = var1).
; Slides 4.2 Variables, slides "Example Code" and "Code Trace: var1 and var2" (same code).
ORG 100h
MOV AL, var1   ; AL <- var1
MOV BX, var2   ; BX <- var2
RET            ; end the program
VAR1 DB 7      ; BYTE, 7
var2 DW 1234h  ; WORD, 1234h

; REGISTERS: AL BX
; MEMORY: var1 3

; Expected output:
; AL=07h
; BX=1234h
; var1: 07h 34h 12h
