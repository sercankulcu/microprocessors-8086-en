; Stack order exercise: the result is AX = 3333h, BX = 1111h, CX = 2222h (4 PUSH, 4 POP).
; Slides: Chapter 8 The Stack, slide "Guess the Result".
ORG 100h          ; not in the slides: .COM program
MOV AX, 1111h
MOV BX, 2222h
MOV CX, 3333h
PUSH AX
PUSH BX
PUSH CX
POP AX
POP CX
PUSH AX
POP BX
POP BX
RET               ; not in the slides: return to DOS

; REGISTERS: AX BX CX
; Expected output:
; AX=3333h
; BX=1111h
; CX=2222h
