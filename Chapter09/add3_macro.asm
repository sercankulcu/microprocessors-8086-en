; The ADD3 macro: a parameter can be a memory variable or a constant.
; ADD3 a, b, c and ADD3 c, 5, d: c = 1545h, d = 154Ah.
; Slides 9.1 "Parameter Types" (definition); use and data from "The ADD3 Macro: Code Trace".

ADD3 MACRO x, y, z
  MOV AX, x
  ADD AX, y
  MOV z, AX
ENDM

OPTION NOKEYWORD:<C>     ; not on the slide: C is a reserved word (language type) in MASM/UASM; not in emu8086
org 100h                 ; not on the slide: use from the code-trace slide
ADD3 a, b, c
ADD3 c, 5, d
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
