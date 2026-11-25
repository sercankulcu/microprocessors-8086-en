; Accessing an array element with a constant index (a[3]) and with an index register (a[SI]); a[1] <- 'E'.
; Slides 4.2 Variables, slide "Code Trace: Accessing Array Elements".
ORG 100h
MOV AL, a[3]   ; a + 3
MOV SI, 0
MOV BL, a[SI]  ; a + 0
INC SI
MOV BH, a[SI]  ; a + 1
MOV a[SI], 'E' ; a[1] <- 45h
RET
a DB 48h,65h,6Ch,6Ch,6Fh,0

; REGISTERS: AL BX SI
; MEMORY: a 6

; Expected output:
; AL=6Ch
; BX=6548h
; SI=0001h
; a: 48h 45h 6Ch 6Ch 6Fh 00h
