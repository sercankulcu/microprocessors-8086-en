; Software delay: MOV CX, N / LOOP takes 17N - 8 clocks in total. N = 281 -> 4769 clocks, about
; 1 ms on a 4.77 MHz 8086. CX = 0 when the loop ends.
; Source: Chapter 10.2 Device Control, "Software Delay"
; REGISTERS: CX

ORG 100h       ; not on the slide
; ≈ 1 ms delay (4.77 MHz 8086)
mov cx, 281    ; 4 clocks
delay:
loop delay     ; 280 × 17 + 1 × 5 clocks
ret            ; not on the slide

; Expected output:
; CX=0000h
