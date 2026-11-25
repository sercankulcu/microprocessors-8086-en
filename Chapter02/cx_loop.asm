; Loop with CX: 5 + 4 + 3 + 2 + 1 = 15 = 000Fh. The body does not run with CX = 0.
; Source: Chapter 2.2 8086 Registers, "Loop with CX" (CX and LOOP: 5 + 4 + 3 + 2 + 1)

org 100h           ; not in the slides: .COM program
MOV CX, 5          ; counter
MOV AX, 0          ; sum
AGAIN: ADD AX, CX
LOOP AGAIN         ; CX--, jump if ≠0
MOV DX, AX         ; result
RET                ; not in the slides: return to DOS

; REGISTERS: AX CX DX

; Expected output:
; AX=000Fh
; CX=0000h
; DX=000Fh
