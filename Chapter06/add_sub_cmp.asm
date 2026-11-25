; Effect of ADD, SUB and CMP on the flags; CMP changes only the flags.
; Source: Chapter 6 slides, "Code Trace: ADD, SUB, CMP".
; REGISTERS: AL BL CF ZF SF OF
org 100h         ; not in the slides: .COM program
mov al, 0F0h     ; 240
add al, 20h      ; 240 + 32 = 272
mov bl, 7
sub bl, 9        ; 7 - 9
cmp al, 10h      ; AL - 10h
cmp bl, 0
add bl, 2        ; FEh + 2
ret              ; not in the slides: end the program

; Expected output:
; AL=10h
; BL=00h
; CF=1
; ZF=1
; SF=0
; OF=0
