; Location counter: n EQU $ - s is the byte count of the string; TYPE, LENGTHOF, SIZEOF read the same information from the definition.
; Slides 4.2 Variables, slide "The Location Counter ($) and Size Operators" (the values in the slide's table).
ORG 100h             ; not in the slides
MOV CX, n            ; not in the slides: 8
MOV AL, TYPE s       ; not in the slides: 1
MOV AH, LENGTHOF s   ; not in the slides: 8
MOV BL, TYPE w       ; not in the slides: 2
MOV BH, LENGTHOF w   ; not in the slides: 10
MOV DX, SIZEOF w     ; not in the slides: 20
RET                  ; not in the slides
s DB 'Welcome', 0
n EQU $ - s        ; 8
w DW 10 DUP(0)

; REGISTERS: CX AX BX DX

; Expected output:
; CX=0008h
; AX=0801h
; BX=0A02h
; DX=0014h
