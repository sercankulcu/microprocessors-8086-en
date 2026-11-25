; Conditional assembly: SHIFTN AX (n empty -> SHL AX, 1) and SHIFTN BX, 3 (MOV CL, 3 / SHL BX, CL);
; because DEBUG = 1, PUTC '*' is assembled. Slides 9.1 "Conditional Assembly";
; usage and values from "Conditional Expansion: Code Trace".
include 'emu8086.inc'    ; not on the slide: the PUTC definition

SHIFTN MACRO r, n
  IFB <n>          ;; n not given?
    SHL r, 1
  ELSE
    MOV CL, n
    SHL r, CL
  ENDIF
ENDM

ORG 100h                 ; not on the slide
mov ax, 5                ; not on the slide
mov bx, 3                ; not on the slide
SHIFTN AX                ; not on the slide
SHIFTN BX, 3             ; not on the slide

DEBUG = 1
IF DEBUG
  PUTC '*'         ; test build only
ENDIF
RET                      ; not on the slide

; REGISTERS: AX BX CL

; Expected output:
; *
; AX=000Ah
; BX=0018h
; CL=03h
