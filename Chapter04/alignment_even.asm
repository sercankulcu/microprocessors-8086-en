; EVEN rounds the location counter up to an even number: a at 0200h, one pad byte, w at 0202h.
; Slides 4.2 Variables, slide "Alignment: Where Does a Word Start?".
ORG 100h         ; not in the slides
MOV BX, OFFSET w ; not in the slides: the offset of w
RET              ; not in the slides
ORG 200h         ; not in the slides: the addresses on the slide
a  DB 5          ; 0200h
   EVEN          ; 0201h: pad
w  DW 1234h      ; 0202h (even)

; REGISTERS: BX
; MEMORY: a 4

; Expected output:
; BX=0202h
; a: 05h 90h 34h 12h
