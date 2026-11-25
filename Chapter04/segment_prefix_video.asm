; Writing to video memory through ES: a blinking 'K' (1Eh) at B800:00A0h; the same offset in DS holds another byte.
; Slides 4.1 Memory Access, slide "Code Trace: Video Memory Through ES".
; 'K' appears on the screen at row 1, column 0; AL and DL show the bytes in the two segments.
ORG 100h
MOV AX, 0B800h
MOV ES, AX         ; ES = video
MOV BX, 00A0h      ; row 1
MOV BYTE PTR ES:[BX], 'K'
MOV BYTE PTR ES:[BX+1], 1Eh
MOV AL, [BX]       ; DS:00A0h
MOV DL, ES:[BX]    ; B800:00A0h
RET

; REGISTERS: DS ES AL DL

; Expected output:
;
; K
; DS=0700h
; ES=B800h
; AL=00h
; DL=4Bh
