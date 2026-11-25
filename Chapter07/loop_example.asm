; LOOP: decrements CX and jumps to the label if it is not zero; the loop runs 5 times.
; Slides: Chapter 7 Flow Control, slide "LOOP Example".
org 100h
mov cx, 5         ; CX = repeat count (5)
again:
; loop body
inc ax            ; not in the slides: counts the iterations in AX
loop again        ; if CX <> 0 jump to again
jmp quit          ; loop finished: jump to quit
quit:
ret

; REGISTERS: AX CX

; Expected output:
; AX=0005h
; CX=0000h
