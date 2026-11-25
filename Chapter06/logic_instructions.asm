; AND, OR, XOR and TEST: upper/lower-casing a letter (bit 5), converting an ASCII digit to a
; number, odd/even check and clearing with XOR.
; Source: Chapter 6 slides, "Code Trace: Logic Instructions".
; REGISTERS: AL BL ZF PF CF OF
org 100h         ; not in the slides: .COM program
mov al, 'a'      ; 61h
and al, 0DFh     ; upper case
or  al, 20h      ; lower case
xor al, 20h      ; toggle
mov bl, '7'      ; 37h
and bl, 0Fh      ; number 7
test bl, 1       ; odd?
xor bl, bl       ; BL = 0
ret              ; not in the slides: end the program

; Expected output:
; AL=41h
; BL=00h
; ZF=1
; PF=1
; CF=0
; OF=0
