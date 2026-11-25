; Real unipolar stepper motor, 8255 port A (310h = 784): half-step sequence 01h 03h 02h 06h
; 04h 0Ch 08h 09h. pos starts at 6: the first OUT is half[7] = 09h, then the sequence wraps
; around. AND BX, 7 keeps the index in 0-7. Endless loop: LIMIT shows the first few steps.
; Source: Chapter 10.2 Device Control, "Half-Step Drive: Code Trace"
; (the delay-free form of the code on the "Real Motor Sequences" slide: motor_sequences.asm)
; LIMIT: 27
; REGISTERS: BX AL
; MEMORY: pos 2

org 100h
fwd:
inc pos          ; reverse: dec pos
mov bx, pos
and bx, 7        ; index 0-7
mov al, half[bx]
mov dx, 310h     ; port A
out dx, al
call delay       ; step gap
jmp fwd
delay: ret       ; (delay)
half db 01h,03h,02h,06h
     db 04h,0Ch,08h,09h
pos  dw 6

; Expected output:
; OUT 784 <- 09h
; OUT 784 <- 01h
; OUT 784 <- 03h
; BX=0001h
; AL=03h
; pos: 09h 00h
