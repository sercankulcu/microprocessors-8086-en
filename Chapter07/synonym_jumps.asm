; JNC, JNB and JAE are the same instruction (73h): all three jump when CF = 0.
; CF = 0 at start, so the first JNC jumps to a and AX = 5.
; Slides: Chapter 7 Flow Control, slide "Synonymous Jumps".
org 100h
jnc a          ; 0100h: 73 07
jnb a          ; 0102h: 73 05
jae a          ; 0104h: 73 03
mov ax, 4      ; 0106h: B8 04 00
a: mov ax, 5   ; 0109h: B8 05 00
ret            ; 010Ch: C3

; REGISTERS: AX
; MEMORY: a 4

; Expected output:
; AX=0005h
; a: B8h 05h 00h C3h
