; LABEL gives the same memory a second name and type: word (WORD) and bytes (BYTE).
; Slides 4.2 Variables, slide "Code Trace: Two Names for the Same Memory (LABEL)".
ORG 100h
MOV AX, wval       ; WORD
MOV BL, bytes      ; low
MOV BH, bytes+1    ; high
MOV bytes, 0FFh    ; one byte
MOV CX, wval       ; word
RET
wval LABEL WORD
bytes DB 34h, 12h

; REGISTERS: AX BX CX
; MEMORY: bytes 2

; Expected output:
; AX=1234h
; BX=1234h
; CX=12FFh
; bytes: FFh 12h
