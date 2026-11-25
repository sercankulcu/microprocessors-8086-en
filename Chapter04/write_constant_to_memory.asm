; Writing a constant to memory: BYTE PTR / WORD PTR sets the size (65 = 41h = 'A').
; Slides 4.1 Memory Access, slide "Writing a Constant to a Memory Address".
ORG 100h
MOV BYTE PTR [4000h], 65  ; 'A'
MOV WORD PTR [4002h], 65
RET
ORG 4000h      ; not in the slides: the earlier memory contents from the trace (00 99 00 99)
area DB 00h, 99h, 00h, 99h   ; not in the slides

; MEMORY: area 4

; Expected output:
; area: 41h 99h 41h 00h
