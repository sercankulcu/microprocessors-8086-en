; The stack works LIFO: 1, 2, 3 are pushed; the POPs return 3, 2, 1 in that order.
; Slides: Chapter 8 The Stack, slide "Example: LIFO Order".
ORG    100h       ; not in the slides: .COM program
MOV    AX, 1      ; AX = 1
PUSH   AX         ; push 1
MOV    AX, 2      ; AX = 2
PUSH   AX         ; push 2
MOV    AX, 3      ; AX = 3
PUSH   AX         ; push 3
POP    BX         ; BX <- 3
POP    BX         ; BX <- 2
POP    BX         ; BX <- 1
RET               ; not in the slides: return to DOS

; REGISTERS: AX BX
; Expected output:
; AX=0003h
; BX=0001h
