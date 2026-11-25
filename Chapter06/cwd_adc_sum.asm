; Sum signed words by extending them to 32 bits with CWD and adding with ADC:
; 30000 + 25000 - 4000 = 51000 = 0000C738h.
; Source: Chapter 6 slides, "A 32-Bit Total with CWD and ADC".
; MEMORY: total 4
org 100h
jmp start
arr dw 30000, 25000, -4000
total dw 0, 0        ; 32-bit total
start:
lea si, arr
mov cx, 3
next:
mov ax, [si]
cwd                  ; AX -> DX:AX
add [total], ax      ; low word
adc [total+2], dx    ; high + CF
add si, 2
loop next
ret

; Expected output:
; total: 38h C7h 00h 00h
