; The power macro: POWER b, e, r -> r = b^e. AX starts at 1 and is multiplied by the base e times.
; base = 2, exponent = 3 -> result = 8. Slides 9.1 "The Power Macro" (two slides).
POWER macro b, e, r
    mov ax, 1        ; result so far = 1
    mov cx, e        ; exponent → CX
    mov bx, b        ; base → BX
powerloop:
    mul bx           ; DX:AX = AX * BX
    loop powerloop   ; repeat e times
    mov r, ax        ; store result
endm

ORG 100h
start:
    POWER base, exponent, result
    ret
base     dw 2     ; base
exponent dw 3     ; exponent
result   dw ?     ; result

; REGISTERS: AX CX DX
; MEMORY: result 2

; Expected output:
; AX=0008h
; CX=0000h
; DX=0000h
; result: 08h 00h
