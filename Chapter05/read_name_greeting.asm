; Reading a buffered line with INT 21h AH = 0Ah, replacing the final CR with '$' and printing it
; with AH = 09h. As in the slides, the user types Ali and presses Enter.
; Source: Chapter 5.2 slides, "Trace: AH = 0Ah".
; INPUT: "Ali\r"
; MEMORY: buffer 6
org 100h
mov dx, offset buffer
mov ah, 0Ah          ; buffered input
int 21h
mov bl, [buffer+1]   ; number of characters read
mov bh, 0
mov byte ptr buffer[bx+2], '$'
mov dx, offset greet
mov ah, 09h
int 21h
lea dx, [buffer+2]
int 21h
ret
buffer db 10, ?, 10 dup(?)
greet  db 0Dh, 0Ah, 'Hello $'

; Expected output:
; Ali
; Hello Ali
; buffer: 0Ah 03h 41h 6Ch 69h 24h
