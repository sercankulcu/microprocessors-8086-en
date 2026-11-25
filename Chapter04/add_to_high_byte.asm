; In 8-bit addition the carry does not move into the neighboring byte; in 16-bit addition it does.
; Slides 4.1 Memory Access, slide "Adding to a Register's High Byte".
; Intermediate step (after ADD AL, 01h): AX = 0100h, CF = 1, ZF = 1.
ORG 100h        ; not in the slides
MOV AX, 00FFh   ; AH = 00h, AL = FFh
ADD AH, 01h     ; AH only
ADD AL, 01h     ; AL only
MOV AX, 01FFh
ADD AX, 1       ; 16 bits
RET             ; not in the slides

; REGISTERS: AX CF ZF SF OF PF AF

; Expected output:
; AX=0200h
; CF=0
; ZF=0
; SF=0
; OF=0
; PF=1
; AF=1
