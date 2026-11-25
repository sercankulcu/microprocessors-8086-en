; One CISC instruction, three jobs: ADD [BX], AX reads memory, adds, and writes back.
; num = 0123h -> 012Ah -> 0131h
; Source: Chapter 1.1 Introduction, "CISC Instruction Inside: Code Trace"
; (the same instruction also appears in the "CISC" and "CISC and RISC Example" slides)

org 100h
mov bx, offset num  ; address
mov ax, 7           ; value
add [bx], ax        ; read, add, write
add [bx], ax        ; again
ret
num dw 0123h

; REGISTERS: BX AX
; MEMORY: num 2

; Expected output:
; BX=010Bh
; AX=0007h
; num: 31h 01h
