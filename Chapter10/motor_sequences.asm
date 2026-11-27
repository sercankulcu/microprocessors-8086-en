; Real unipolar stepper motor, 8255 port A (310h = 784): half-step sequence 01h 03h 02h 06h
; 04h 0Ch 08h 09h. pos starts at 6, INC makes the first OUT half[7] = 09h; AND BX, 7 keeps the
; index in 0-7. delay (CX = 2500 LOOP iterations, ~10 ms) sets the step interval, i.e. the speed.
; Endless loop: each step is ~2510 instructions; LIMIT shows the first three steps.
; Source: Chapter 10.2 Device Control, "Real Motor Sequences"
; LIMIT: 6000
; MEMORY: pos 2

ORG 100h         ; not on the slide
; assume port A was set as output with 82h
fwd:
inc pos          ; for reverse: dec pos
mov bx, pos
and bx, 7        ; index 0-7
mov al, half[bx]
mov dx, 310h     ; port A
out dx, al
call delay       ; step gap = speed
jmp fwd
delay:           ; ≈ 10 ms delay
mov cx, 2500
loop $
ret
half db 01h,03h,02h,06h
     db 04h,0Ch,08h,09h
pos  dw 6

; Expected output:
; OUT 784 <- 09h
; OUT 784 <- 01h
; OUT 784 <- 03h
; pos: 09h 00h
