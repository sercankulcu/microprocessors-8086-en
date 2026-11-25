; XCHG swaps two registers in one instruction.
; Slides 4.1 Memory Access, slide "Swapping Two Registers".
ORG 100h     ; not in the slides
MOV CX, 10   ; CX = 000Ah
MOV DX, 20   ; DX = 0014h
XCHG CX, DX  ; swap
RET          ; not in the slides

; REGISTERS: CX DX

; Expected output:
; CX=0014h
; DX=000Ah
