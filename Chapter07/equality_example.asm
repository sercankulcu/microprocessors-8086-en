; Equality test with CMP and JE: AX = BX = 5, so ZF = 1 and the jump to equal_message is taken.
; Slides: Chapter 7 Flow Control, slide "Equality Example".
org 100h              ; not in the slides: .COM program
mov ax, 5
mov bx, 5
cmp ax, bx
je  equal_message
jmp not_equal_message
equal_message:        ; if equal
mov cx, 1             ; not in the slides: shows which branch ran
jmp end_program
not_equal_message:    ; if not equal
mov cx, 2             ; not in the slides: shows which branch ran
end_program:
ret                   ; not in the slides: return to DOS

; REGISTERS: AX BX CX ZF

; Expected output:
; AX=0005h
; BX=0005h
; CX=0001h
; ZF=1
