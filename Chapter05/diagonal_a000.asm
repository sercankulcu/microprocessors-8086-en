; Writing a diagonal straight into the A000h graphics memory: (x, y) = y*320 + x, so each step
; advances by 321 (141h). It waits for a key, then returns to text mode. The code trace uses the same loop with CX = 4.
; Source: Chapter 5.2 slides, "Diagonal Drawing" (with A000h) and "Diagonal with A000h: Code Trace".
; INPUT: " "
; REGISTERS: DI
org 100h         ; not in the slides: a .COM program
mov ax, 0013h
int 10h
mov ax, 0A000h
mov es, ax
xor di, di       ; (0,0) -> relative offset 0
mov al, 0Eh      ; yellow
mov cx, 200
draw: mov es:[di], al
add di, 141h     ; 320 + 1
loop draw
mov ah, 0
int 16h          ; wait for a key
mov ax, 0003h
int 10h          ; back to text mode
ret              ; not in the slides: end the program

; Expected output:
; DI=FAC8h
