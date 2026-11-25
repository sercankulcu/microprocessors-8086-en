; Register-saving macros: SAVE pushes four registers on the stack, RESTORE pops them in reverse order.
; Slides 9.1 "Register-Saving Macros" (definitions; a trial use was added).

SAVE MACRO
  PUSH AX
  PUSH BX
  PUSH CX
  PUSH DX
ENDM

RESTORE MACRO
  POP DX
  POP CX
  POP BX
  POP AX
ENDM

ORG 100h                 ; not on the slide: trial use
MOV  AX, 1111h           ; not on the slide
MOV  BX, 2222h           ; not on the slide
MOV  CX, 3333h           ; not on the slide
MOV  DX, 4444h           ; not on the slide
SAVE
XOR  AX, AX              ; not on the slide: wreck the registers
XOR  BX, BX              ; not on the slide
XOR  CX, CX              ; not on the slide
XOR  DX, DX              ; not on the slide
RESTORE
RET                      ; not on the slide

; REGISTERS: AX BX CX DX

; Expected output:
; AX=1111h
; BX=2222h
; CX=3333h
; DX=4444h
