; The expansion the assembler produces for the calls MyMacro 1, 2, 3 and MyMacro 4, 5, DX:
; the two calls became 6 instructions. Slides 9.1 "Macro Expansion" (last expansion), "MyMacro Running".
ORG 100h
MOV AX, 00001h   ; MyMacro 1, 2, 3
MOV BX, 00002h
MOV CX, 00003h
MOV AX, 00004h   ; MyMacro 4, 5, DX
MOV BX, 00005h
MOV CX, DX
RET

; REGISTERS: AX BX CX

; Expected output:
; AX=0004h
; BX=0005h
; CX=0000h
