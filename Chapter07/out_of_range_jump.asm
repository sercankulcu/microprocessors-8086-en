; A conditional jump on the 8086 can only be short (-128..+127). If the target is 200 bytes away,
; combine a short jump on the opposite condition with a near JMP (E9).
; Slides: Chapter 7 Flow Control, slides "Out-of-Range Conditional Jump".
;
; Wrong form (the first code on the slides; emu8086 reports "out of range"):
;     cmp al, 0
;     je  far_away    ; out of range!
;     ; ... 200 bytes of code ...
;     far_away:
;
; Correct form:
org 100h            ; not in the slides: .COM program
cmp al, 0
jne go_on       ; opposite condition, short
jmp far_away    ; near JMP (E9)
go_on:
; ... 200 bytes of code ...
mov bx, 1           ; not in the slides: BX = 1 if execution gets here
db 197 dup (90h)    ; not in the slides: NOPs that fill up to 200 bytes
far_away:
ret                 ; not in the slides: return to DOS

; AL = 0, so JNE is not taken and JMP far_away skips over the 200 bytes: BX stays 0.
; REGISTERS: AL BX

; Expected output:
; AL=00h
; BX=0000h
