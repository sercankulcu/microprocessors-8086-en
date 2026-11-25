; LEA gives the address of a variable; the variable is reached by name and also through the [BX] pointer.
; Slides 4.2 Variables, slide "Code Trace: Updating a Variable Through LEA".
ORG 100h
MOV AL, VAR1          ; value
LEA BX, VAR1          ; address
MOV BYTE PTR [BX], 44h
MOV AL, VAR1          ; new value
RET
VAR1 DB 22h
END

; REGISTERS: AL BX
; MEMORY: VAR1 1

; Expected output:
; AL=44h
; BX=010Dh
; VAR1: 44h
