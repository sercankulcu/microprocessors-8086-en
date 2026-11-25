; A parameter is text, not a value: AREA 2+3, 4 -> MOV AX, 2+3*4 = 14 (20 was expected).
; With parentheses in the body, (2+3)*(4) = 20. DIFF 10, 4+1 -> MOV CX, 10-4+1 = 7.
; Slides 9.1 "Parameter Expressions and Precedence" (definitions; calls from the slide's table).

AREA MACRO wd, ht
  MOV AX, wd*ht
ENDM

DIFF MACRO p, q
  MOV CX, p-q
ENDM

AREA_P MACRO wd, ht      ; not on the slide: the table's "fixed AREA" (parenthesized body)
  MOV AX, (wd)*(ht)
ENDM

ORG 100h                 ; not on the slide: calls from the slide's table
AREA 2+3, 4
MOV BX, AX               ; not on the slide: save the first result
AREA_P 2+3, 4
DIFF 10, 4+1
RET                      ; not on the slide

; REGISTERS: BX AX CX

; Expected output:
; BX=000Eh
; AX=0014h
; CX=0007h
