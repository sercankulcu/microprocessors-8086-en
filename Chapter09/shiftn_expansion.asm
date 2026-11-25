; The expansions of SHIFTN AX and SHIFTN BX, 3: the same macro produced code of two different
; lengths (2 bytes and 4 bytes). Slides 9.1 "Conditional Expansion: Code Trace".
org 100h
mov ax, 5
mov bx, 3
shl ax, 1      ; SHIFTN AX
mov cl, 3      ; SHIFTN BX, 3
shl bx, cl
ret

; REGISTERS: AX BX CL CF

; Expected output:
; AX=000Ah
; BX=0018h
; CL=03h
; CF=0
