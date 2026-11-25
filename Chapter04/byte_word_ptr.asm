; byte ptr and word ptr: the same constant (0FFh) is written as a byte or as a word; little-endian.
; Slides 4.1 Memory Access, slide "Code Trace: byte ptr and word ptr".
ORG 100h           ; not in the slides
MOV BX, 0200h
MOV WORD PTR [BX], 1234h
MOV BYTE PTR [BX], 0FFh
MOV WORD PTR [BX], 0FFh
MOV AX, [BX]        ; word
MOV CL, [BX+1]      ; byte
RET                ; not in the slides
ORG 0200h          ; not in the slides: the earlier memory contents from the trace (AA BB CC DD)
old DB 0AAh, 0BBh, 0CCh, 0DDh   ; not in the slides

; REGISTERS: AX CL
; MEMORY: old 4

; Expected output:
; AX=00FFh
; CL=00h
; old: FFh 00h CCh DDh
