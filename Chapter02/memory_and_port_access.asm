; Memory and I/O access: the same address and data buses go to both memory and I/O ports;
; the M/IO' signal tells them apart. MOV accesses memory, IN/OUT access a port.
; Sample values: 5Ah at address 10200h, 3Ch at port 51h.
; Source: Chapter 2.1 8086 Architecture, "Memory and I/O Access: Code Trace"

cell EQU 0201h          ; not in the slides: the name of address 1000:0201 for the MEMORY directive

org 100h
mov ax, 1000h
mov ds, ax
mov bx, 0200h
mov byte ptr [bx], 5Ah   ; not in the slides: the slide's sample value (10200h = 5Ah)
mov al, [bx]     ; memory read
out 50h, al      ; I/O write
in al, 51h       ; I/O read
mov [bx+1], al   ; memory write
ret

; PORT 81: 3Ch
; REGISTERS: AL
; MEMORY: cell 1

; Expected output (port 50h = 80):
; OUT 80 <- 5Ah
; AL=3Ch
; cell: 3Ch
