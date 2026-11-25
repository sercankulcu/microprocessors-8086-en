; The LOCAL directive: MyMacro2 is used three times, label1/label2 get new names at each expansion.
; AX = 2 -> label1: INC + ADD -> 5; AX = 3 -> label2: ADD -> 5; AX = 7 -> 10.
; Slides 9.1 "The LOCAL Directive" (definition); values from the "MyMacro2 Running" slide.

MyMacro2 MACRO
    LOCAL label1, label2
    CMP  AX, 2
    JE   label1
    CMP  AX, 3
    JE   label2
label1:
    INC  AX
label2:
    ADD  AX, 2
ENDM

ORG 100h                 ; not on the slide: three uses
MOV  AX, 2               ; not on the slide
MyMacro2
MOV  BX, AX              ; not on the slide
MOV  AX, 3               ; not on the slide
MyMacro2
MOV  CX, AX              ; not on the slide
MOV  AX, 7               ; not on the slide
MyMacro2
RET                      ; not on the slide

; REGISTERS: BX CX AX

; Expected output:
; BX=0005h
; CX=0005h
; AX=000Ah
