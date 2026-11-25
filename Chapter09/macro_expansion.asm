; The MyMacro macro: the definition and two uses (constants, and a register as a parameter).
; The assembler expands each call into three MOV instructions; there is no CALL/RET at run time.
; Slides 9.1 "Defining a Macro", "Macro Expansion".

MyMacro  MACRO  p1, p2, p3
         MOV AX, p1
         MOV BX, p2
         MOV CX, p3
ENDM

ORG 100h                 ; not on the slide: COM program
MyMacro 1, 2, 3
MyMacro 4, 5, DX
RET                      ; not on the slide: the RET at the end of the expansion listing

; DX is 0 at the start, so CX = 0.
; REGISTERS: AX BX CX

; Expected output:
; AX=0004h
; BX=0005h
; CX=0000h
