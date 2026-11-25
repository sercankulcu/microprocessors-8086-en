; x = a + b machine code: A1 00 02 | 03 06 02 02 | A3 04 02 | C3 (11 bytes).
; Assumption (as in the slide): a = 0015h (21) at 0200h, b = 0027h (39) at 0202h.
; Source: Chapter 3.1 Programming Languages, "x = a + b: Machine Code Trace"

code EQU 0100h    ; not in the slide: start of the code, for the MEMORY directive

org 100h
mov ax, [0200h]   ; A1 00 02
add ax, [0202h]   ; 03 06 02 02
mov [0204h], ax   ; A3 04 02
ret               ; C3

org 0200h         ; not in the slide: the slide's data
a dw 0015h        ; not in the slide
b dw 0027h        ; not in the slide
x dw ?            ; not in the slide

; REGISTERS: AX
; MEMORY: code 11
; MEMORY: x 2

; Expected output:
; AX=003Ch
; code: A1h 00h 02h 03h 06h 02h 02h A3h 04h 02h C3h
; x: 3Ch 00h
