; RET in a macro: EMIT MACRO c / MOV AL, c / MOV AH, 0Eh / INT 10h / RET / ENDM.
; The macro is not called with CALL; the RET in the body pops the 0000h on the stack and
; the INT 20h at PSP:0000 ends the program. EMIT 'B' never runs, only A is on the screen.
; The code is the expansion of the two calls (EMIT 'A', EMIT 'B'). Slides 9.1 "RET in a Macro: Code Trace".
org 100h
mov al, 'A'    ; EMIT 'A'
mov ah, 0Eh
int 10h
ret            ; the macro's RET
mov al, 'B'    ; EMIT 'B'
mov ah, 0Eh
int 10h
ret
ret

; REGISTERS: AX

; Expected output:
; A
; AX=0E41h
