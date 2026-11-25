; Instruction lengths: 8086 instructions are 1 to 6 bytes long. Six instructions take 15 bytes:
; 41 | BB 50 40 | 8B C3 | 04 7C | C7 87 34 12 78 56 | C3
; Source: Chapter 2.1 8086 Architecture, "Instruction Lengths: Code Trace"

code EQU 0100h           ; not in the slides: start of the code, for the MEMORY directive
data EQU 5284h           ; not in the slides: for the MEMORY directive, EA = 4050h + 1234h

org 100h
inc cx
mov bx, 4050h
mov ax, bx
add al, 7Ch
mov word ptr [bx+1234h], 5678h
ret

; REGISTERS: AX BX CX
; MEMORY: code 15
; MEMORY: data 2

; Expected output (CX is taken as 0 initially):
; AX=40CCh
; BX=4050h
; CX=0001h
; code: 41h BBh 50h 40h 8Bh C3h 04h 7Ch C7h 87h 34h 12h 78h 56h C3h
; data: 78h 56h
