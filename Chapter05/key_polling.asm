; Polling for a key without waiting with INT 16h AH = 01h (ZF = 1: no key), and fetching it from the
; buffer with AH = 00h when it arrives. The key is ready at once, so the background work runs once (DX = 1).
; Source: Chapter 5.2 slides, "Trace: Key Polling".
; INPUT: "x"
; REGISTERS: DX AL
org 100h
xor dx, dx       ; work counter
poll:
inc dx           ; background work
mov ah, 01h      ; is there a key?
int 16h          ; ZF=1 -> none
jz poll
mov ah, 00h      ; take the key from the buffer
int 16h
ret

; Expected output:
; DX=0001h
; AL=78h
