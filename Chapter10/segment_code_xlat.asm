; 7-segment display: convert a digit (0-9) to a common-cathode segment code with XLAT and
; write it to 8255 port A (310h = 784). Digit 3 -> 4Fh.
; Source: Chapter 10.2 Device Control, "Display Table and Scanning" (first part)
; REGISTERS: AL

ORG 100h           ; not on the slide
; convert the digit (0-9) to a segment code
mov bx, offset segtab
mov al, 3        ; digit
xlat              ; AL = [BX + AL] = 4Fh
; not al          ; if common anode
mov dx, 310h     ; 8255 port A
out dx, al
ret
segtab db 3Fh,06h,5Bh,4Fh,66h
       db 6Dh,7Dh,07h,7Fh,6Fh

; Expected output:
; OUT 784 <- 4Fh
; AL=4Fh
