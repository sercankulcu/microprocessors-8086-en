; AAS: adjust after unpacked BCD subtraction. 5 - 8 = FDh -> AL = 7, 1 borrowed from AH
; (like 15 - 8), CF = 1.
; Source: Chapter 6 slides, "AAS: Adjust After Subtraction".
; INPUT: " "
org 100h        ; not in the slides: .COM program
; make 5 - 8, al = 0fdh (not in bcd form)
mov     al, 05h
mov     bl, 08h
sub     al, bl
; convert to bcd, al = 7
; and 1 is borrowed from ah,
; like calculating 15 - 8:
aas
; --- print ---
or      al, 30h
mov     ah, 0Eh
int     10h
mov     ah, 0
int     16h
ret

; Expected output:
; 7
