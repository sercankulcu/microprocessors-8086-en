; Decide with CMP and JE, then print one character with DOS function 02h: 25 <> 10, so it prints n.
; Slides: Chapter 7 Flow Control, slide "CMP and Printing a Character".
org    100h
mov    al, 25     ; al = 25
mov    bl, 10     ; bl = 10
cmp    al, bl     ; compare al - bl
je     equal      ; jump if al = bl (zf = 1)
mov    dl, 'n'    ; al <> bl: print 'n'
jmp    prt        ; go to the common print line
equal:
mov    dl, 'y'    ; al = bl: print 'y'
prt:
mov    ah, 2      ; DOS: print the character in DL
int    21h
ret               ; return to DOS

; REGISTERS: AL

; Expected output:
; n
; AL=6Eh
