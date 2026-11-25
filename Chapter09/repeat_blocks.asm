; Repeat blocks: REPT 3 -> SHL AX, 1 three times (AX x 8); IRP -> PUSH AX, PUSH BX, PUSH CX;
; IRPC -> PUTC 'O', PUTC 'K'. Slides 9.1 "Repeat Blocks" (three slides).
include 'emu8086.inc'    ; not on the slide: the PUTC definition
ORG 100h                 ; not on the slide
MOV AX, 1                ; not on the slide
REPT 3
  SHL AX, 1
ENDM
MOV BX, 2                ; not on the slide
MOV CX, 3                ; not on the slide
IRP r, <AX,BX,CX>
  PUSH r
ENDM
POP DX                   ; not on the slide: the last pushed, CX
POP SI                   ; not on the slide: BX
POP DI                   ; not on the slide: AX
IRPC c, OK
  PUTC '&c'
ENDM
RET                      ; not on the slide

; REGISTERS: AX DX SI DI

; Expected output:
; OK
; AX=0008h
; DX=0003h
; SI=0002h
; DI=0008h
