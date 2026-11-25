; 8255 PPI: control word 82h (A output, B input, C output, mode 0), read the switches on port B
; and write them to the LEDs on port A, set PC7 = 1 with the BSR word 0Fh.
; Port addresses: A = 310h (784), B = 311h (785), control = 313h (787). Switches read 96h.
; Source: Chapter 10.2 Device Control, "8255 Control Word" and "8255 Setup: Code Trace"
; PORT 785: 96h
; REGISTERS: AL DX

org 100h
mov dx, 313h   ; control register
mov al, 82h    ; A,C out; B in
out dx, al
mov dx, 311h   ; port B
in  al, dx     ; read switches
mov dx, 310h   ; port A
out dx, al     ; drive the LEDs
mov dx, 313h
mov al, 0Fh    ; BSR: PC7 = 1
out dx, al
ret

; Expected output:
; OUT 787 <- 82h
; OUT 784 <- 96h
; OUT 787 <- 0Fh
; AL=0Fh
; DX=0313h
