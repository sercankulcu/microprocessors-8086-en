; A macro that contains a label defines the same label twice when it is used twice.
; The faulty macro from the slides (does not assemble; emu8086: "Duplicate declaration"):
;
;   DELAY MACRO
;   lp:   DEC CX
;         JNZ lp
;   ENDM
;
;   MOV CX, 5
;   DELAY
;   MOV CX, 9
;   DELAY
;
; What the assembler sees:
;
;   MOV CX, 5
;   lp:   DEC CX    ; copy 1
;         JNZ lp
;   MOV CX, 9
;   lp:   DEC CX    ; copy 2 !
;         JNZ lp
;
; The fixed version is below: LOCAL lp, the first line of the body; at every expansion lp
; gets a new name (??0000, ??0001). Slides 9.1 "The Label Problem" (two slides), "The LOCAL Directive".

DELAY MACRO
      LOCAL lp            ; not on the slide: the fix ("the macro has LOCAL lp" on the code-trace slide)
lp:   DEC CX
      JNZ lp
ENDM

ORG 100h                  ; not on the slide
MOV CX, 5
DELAY
MOV CX, 9
DELAY
RET                       ; not on the slide

; REGISTERS: CX ZF

; Expected output:
; CX=0000h
; ZF=1
