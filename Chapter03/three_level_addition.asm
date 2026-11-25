; The same operation at three levels: x = a + b in C; three instructions in assembly.
; The machine-language column of the slide uses the addresses a = 0200h, b = 0202h,
; x = 0204h; the variables are placed at those addresses here. a = 0015h (21),
; b = 0027h (39) -> x = 003Ch (60).
; Source: Chapter 3.1 Programming Languages, "The Same Operation at Three Levels"

org 100h        ; not in the slide: .COM program
MOV AX, [a]     ; load a into AX
ADD AX, [b]     ; AX = AX + b
MOV [x], AX     ; store the result in x
RET             ; not in the slide: back to DOS

org 0200h       ; not in the slide: variables at the slide's addresses
a dw 0015h      ; not in the slide
b dw 0027h      ; not in the slide
x dw ?          ; not in the slide

; REGISTERS: AX
; MEMORY: x 2

; Expected output:
; AX=003Ch
; x: 3Ch 00h
