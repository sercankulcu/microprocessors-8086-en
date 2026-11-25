; REP MOVSB: "ABC" at DS:SI is copied to ES:DI; with CLD, SI and DI increase at every step.
; Source: Chapter 2.2 8086 Registers, "REP MOVSB" (String Copy with SI and DI)

org 100h         ; not in the slides: .COM program
CLD              ; DF=0: addresses go up
MOV SI, 0200h    ; source
MOV DI, 0300h    ; destination
MOV CX, 3        ; byte count
REP MOVSB        ; ES:[DI] ← DS:[SI]
RET              ; not in the slides: return to DOS

org 0200h               ; not in the slides: the slide's source string is at DS:0200h
source db 'ABC'         ; not in the slides
org 0300h               ; not in the slides: the destination area is at DS:0300h
dest   db 4 dup(0)      ; not in the slides

; REGISTERS: SI DI CX
; MEMORY: dest 4

; Expected output:
; SI=0203h
; DI=0303h
; CX=0000h
; dest: 41h 42h 43h 00h
