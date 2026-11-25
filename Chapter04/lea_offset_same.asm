; MOV BX, OFFSET VAR1 instead of LEA BX, VAR1: the same result, a fixed address known at assembly time.
; Slides 4.2 Variables, slide "Are LEA and OFFSET the Same?".
ORG 100h
MOV AL, VAR1
MOV BX, OFFSET VAR1
MOV BYTE PTR [BX], 44h
MOV AL, VAR1
RET
VAR1 DB 22h
END

; REGISTERS: AL BX
; MEMORY: VAR1 1

; Expected output:
; AL=44h
; BX=010Dh
; VAR1: 44h
