; Drawing a diagonal in the 320 x 200 graphics mode (13h) with INT 10h AH = 0Ch: 200 pixels.
; The pixel output is not visible in the test environment; the end of the loop is checked through the registers.
; Source: Chapter 5.2 slides, "Diagonal Drawing" (with the BIOS).
; REGISTERS: CX DX
org 100h         ; not in the slides: a .COM program
mov ax, 0013h
int 10h          ; 320x200, 256 colors
xor cx, cx       ; x = 0
xor dx, dx       ; y = 0
mov bh, 0        ; page
dot: mov ax, 0C0Eh ; AH=0Ch, AL=yellow
int 10h
inc cx           ; one right
inc dx           ; one down
cmp dx, 200
jb  dot          ; 200 pixels
ret              ; not in the slides: end the program

; Expected output:
; CX=00C8h
; DX=00C8h
