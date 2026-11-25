; Memory to register: MOV AX, [1000h] reads two bytes little-endian (CD AB -> ABCDh).
; Slides 4.1 Memory Access, slide "Moving a Value from Memory into a Register".
ORG 100h
MOV AX, [1000h]   ; A1 00 10
RET
ORG 1000h         ; not in the slides: the memory contents from the trace (DS:1000h = CD AB)
value DB 0CDh, 0ABh   ; not in the slides

; REGISTERS: AX

; Expected output:
; AX=ABCDh
