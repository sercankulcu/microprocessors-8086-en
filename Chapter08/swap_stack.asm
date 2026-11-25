; Swap with the stack: PUSH AX, PUSH BX, POP AX, POP BX exchange the values of two registers.
; Slides: Chapter 8 The Stack, slides "Example: Swap" and "Swap Methods" (method 1).
ORG    100h
MOV    AX, 1212h  ; AX <- 1212h
MOV    BX, 3434h  ; BX <- 3434h
PUSH   AX         ; push AX
PUSH   BX         ; push BX
POP    AX         ; AX <- old BX
POP    BX         ; BX <- old AX
RET
END

; REGISTERS: AX BX
; Expected output:
; AX=3434h
; BX=1212h
