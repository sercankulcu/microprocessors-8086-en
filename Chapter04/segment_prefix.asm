; Segment prefix: ES:[BX] reads video memory, [BX] reads DS, SS:[SI] reads the stack segment.
; Slides 4.1 Memory Access, slide "Segment Override Prefix".
; In a .COM, DS = the PSP segment: DS:0000 holds the INT 20h instruction (CD 20), so AL = CDh.
ORG 100h            ; not in the slides
MOV AX, 0B800h
MOV ES, AX          ; ES = video memory
MOV BX, 0
MOV AL, ES:[BX]     ; read ES:0000
MOV AL, [BX]        ; read DS:0000
MOV DL, SS:[SI]     ; read SS:SI
RET                 ; not in the slides

; REGISTERS: ES AL

; Expected output:
; ES=B800h
; AL=CDh
