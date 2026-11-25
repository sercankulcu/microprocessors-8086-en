; Labels and names: a code label (start:, again:) is the address of an instruction and
; ends with a colon; a variable name (num) is written without a colon and stores its
; type and address together. The loop increments AX 3 times.
; Source: Chapter 3.2 Assembly, "Labels and Names"

org 100h            ; not in the slide: .COM program
start:  MOV CX, 3   ; code label
again:  INC AX
        LOOP again  ; again = address
        RET
num     DB 7        ; data name

; REGISTERS: AX CX
; MEMORY: num 1

; Expected output (AX is assumed to be 0 at the start):
; AX=0003h
; CX=0000h
; num: 07h
