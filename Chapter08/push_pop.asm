; PUSH AX / POP BX: a value is copied from AX to BX through the stack (42 = 002Ah).
; Slides: Chapter 8 The Stack, slide "Example: PUSH AX / POP BX".
ORG    100h
MOV    AX, 42     ; AX = 42
PUSH   AX         ; push AX
POP    BX         ; pop into BX
RET               ; return to the OS
END

; REGISTERS: AX BX
; Expected output:
; AX=002Ah
; BX=002Ah
