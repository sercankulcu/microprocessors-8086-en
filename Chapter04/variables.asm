; Defining variables: DB is one byte, DW is one word (little-endian).
; Slides 4.2 Variables, slide "Variables".
ORG 100h           ; not in the slides
RET                ; not in the slides
counter DB 10h     ; BYTE
sum     DW 0FFFFh  ; WORD

; MEMORY: counter 1
; MEMORY: sum 2

; Expected output:
; counter: 10h
; sum: FFh FFh
