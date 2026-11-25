; Shift-and-add multiplication: each bit of the multiplier is moved into CF with SHR; if the
; bit is 1 the multiplicand is added; at each step the multiplicand is doubled with SHL.
; 13 x 5 = 65 = 41h.
; Source: Chapter 6 slides, "Trace: Shift-and-Add Multiplication".
; MEMORY: result 1
org 100h
mov bl, mcand     ; 13
mov dl, mplier    ; 5 = 0101b
mov cx, 4         ; 4 bits
check:
shr dl, 1         ; low bit -> CF
jnc skip
add result, bl    ; add if bit is 1
skip:
shl bl, 1         ; mcand x 2
loop check
ret
mcand  db 13
mplier db 5
result db 0

; Expected output:
; result: 41h
