; Unsigned comparison with JA: 5 > 7 is false, CF = 1 and the not_jump_above branch runs.
; Slides: Chapter 7 Flow Control, slide "Unsigned Example".
org 100h          ; not in the slides: .COM program
mov ax, 5
mov bx, 7
cmp ax, bx
ja  jump_above
jmp not_jump_above
jump_above:       ; if ax is greater
mov cx, 1         ; not in the slides: shows which branch ran
jmp end_program
not_jump_above:   ; if ax is less/equal
mov cx, 2         ; not in the slides: shows which branch ran
end_program:
ret               ; not in the slides: return to DOS

; REGISTERS: AX BX CX CF ZF

; Expected output:
; AX=0005h
; BX=0007h
; CX=0002h
; CF=1
; ZF=0
