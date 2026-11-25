; Register to memory: MOV [2000h], BX -> [2000h] = 34h, [2001h] = 12h.
; Slides 4.1 Memory Access, slide "Moving a Register Value into Memory".
ORG 100h
MOV BX, 1234h     ; BB 34 12
MOV [2000h], BX   ; 89 1E 00 20
RET
target EQU 2000h  ; not in the slides: a name for the MEMORY directive

; REGISTERS: BX
; MEMORY: target 2

; Expected output:
; BX=1234h
; target: 34h 12h
