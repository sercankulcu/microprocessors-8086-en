; Counting clocks in a delay loop: MOV CX, 4 (4 clocks) + 3 x LOOP taken (17) + LOOP not taken (5)
; = 60 clocks. The emulator does not measure timing; only CX reaching 0 is verified.
; Source: Chapter 10.2 Device Control, "Delay Loop: Code Trace"
; REGISTERS: CX

org 100h
mov cx, 4      ; 4 clocks
delay:
loop delay     ; 17 clocks, the last one 5
ret

; Expected output:
; CX=0000h
