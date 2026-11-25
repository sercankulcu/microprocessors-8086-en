; Saving a value on the stack: AX is used temporarily for other work, POP brings back its old value.
; Slides: Chapter 8 The Stack, slide "Example: Saving a Value".
ORG    100h
MOV    AX, 1234h
PUSH   AX         ; save the value of AX
MOV    AX, 5678h  ; change AX
POP    AX         ; restore the old value
RET
END

; REGISTERS: AX
; Expected output:
; AX=1234h
