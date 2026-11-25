; Sum signed bytes by extending them to 16 bits with CBW: 100 - 30 + 90 - 7 = 153 = 0099h.
; Source: Chapter 6 slides, "Signed Byte Sum with CBW".
; MEMORY: total 2
org 100h
jmp start
arr db 100, -30, 90, -7
total dw 0
start:
lea si, arr
mov cx, 4
xor bx, bx      ; BX = 16-bit sum
next:
mov al, [si]
cbw             ; AL -> AX (sign-extend)
add bx, ax
inc si
loop next
mov total, bx   ; 153 = 0099h
ret

; Expected output:
; total: 99h 00h
