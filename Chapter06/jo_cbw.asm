; Signed overflow: -92 + -92 = -184 does not fit in eight bits (OF = 1); JO jumps to a CBW
; part and the addition is done in 16 bits: AX = FF48h = -184.
; Source: Chapter 6 slides, "Signed Overflow: JO and CBW".
; REGISTERS: AX OF
org 100h         ; not in the slides: .COM program
mov al, -92      ; A4h
mov bl, -92
add al, bl       ; 8-bit addition
jo  widen        ; if OF = 1
jmp done
widen:
mov al, -92      ; first number
cbw              ; AL -> AX
mov dx, ax
mov al, bl       ; second number
cbw
add ax, dx       ; 16-bit addition
done:
ret

; Expected output:
; AX=FF48h
; OF=0
