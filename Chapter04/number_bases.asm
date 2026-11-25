; Assignment and addition/subtraction with binary (b), hexadecimal (h) and octal (o) constants.
; Slides 4.1 Memory Access, slide "Loading Binary, Octal and Hex Values".
ORG 100h          ; not in the slides
mov al, 00000101b ; binary
mov bl, 0ah       ; hex
mov cl, 10o       ; octal
add al, bl        ; 5 + 10 = 15
sub al, cl        ; 15 - 8 = 7
RET               ; not in the slides

; REGISTERS: AL BL CL CF PF

; Expected output:
; AL=07h
; BL=0Ah
; CL=08h
; CF=0
; PF=0
