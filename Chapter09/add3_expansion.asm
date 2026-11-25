; The expansion of the calls ADD3 a, b, c and ADD3 c, 5, d: the same body, different text.
; Slides 9.1 "The ADD3 Macro: Code Trace".
OPTION NOKEYWORD:<C>     ; not on the slide: C is a reserved word (language type) in MASM/UASM; not in emu8086
org 100h
mov ax, a      ; ADD3 a, b, c
add ax, b
mov c, ax
mov ax, c      ; ADD3 c, 5, d
add ax, 5
mov d, ax
ret
a dw 1200h
b dw 0345h
c dw ?
d dw ?

; REGISTERS: AX
; MEMORY: c 2
; MEMORY: d 2

; Expected output:
; AX=154Ah
; c: 45h 15h
; d: 4Ah 15h
