; INT 15h, AH = 86h: waits CX:DX microseconds. 5 000 000 us = 004C4B40h -> CX = 004Ch,
; DX = 4B40h. On success CF = 0 (in the test environment the time counts as elapsed).
; Source: Chapter 10.2 Device Control, "Waiting with INT 15h"
; REGISTERS: CX DX CF

ORG 100h       ; not on the slide
; wait 5 seconds (5 million µs)
mov cx, 4Ch    ; 004C4B40h = 5 000 000
mov dx, 4B40h
mov ah, 86h
int 15h
ret            ; not on the slide

; Expected output:
; CX=004Ch
; DX=4B40h
; CF=0
