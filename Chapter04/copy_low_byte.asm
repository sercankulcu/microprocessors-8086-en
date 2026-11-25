; An 8-bit MOV changes only BL; BH is preserved.
; Slides 4.1 Memory Access, slide "Copying a Register's Low Byte into Another".
ORG 100h        ; not in the slides
MOV AX, 1234h   ; AH = 12h, AL = 34h
MOV BX, 0FFFFh
MOV BL, AL      ; BL only
RET             ; not in the slides

; REGISTERS: AX BX

; Expected output:
; AX=1234h
; BX=FF34h
