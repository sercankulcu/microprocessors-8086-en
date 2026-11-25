; BIOS data area (segment 0040h): waiting about 1 second (18 ticks) with the tick counter at 006Ch;
; checking Caps Lock in the keyboard status byte at 0017h and the keyboard buffer via 001Ah/001Ch.
; The label targets and the printing are not in the slides: since Caps Lock is off and the buffer is empty,
; 'B' is written (AH = 02h, AL = the character written).
; Source: Chapter 5.2 slides, "Waiting with the Tick Counter".
; REGISTERS: AX
org 100h            ; not in the slides: a .COM program
; wait about 1 second
mov ax, 0040h
mov es, ax
mov bx, es:[006Ch]  ; starting tick
wait1:
mov ax, es:[006Ch]  ; current tick
sub ax, bx          ; elapsed ticks
cmp ax, 18          ; 18 ticks = 0.99 s
jb  wait1

; Is Caps Lock on? Is there a pending key?
test byte ptr es:[0017h], 40h
jnz caps_on         ; bit 6 = 1
mov ax, es:[001Ah]  ; buffer head
cmp ax, es:[001Ch]  ; buffer tail
je  buf_empty
mov dl, 'T'         ; not in the slides: a key is in the buffer
jmp emit            ; not in the slides
caps_on:            ; not in the slides
mov dl, 'C'         ; not in the slides
jmp emit            ; not in the slides
buf_empty:          ; not in the slides
mov dl, 'B'         ; not in the slides
emit:               ; not in the slides
mov ah, 02h         ; not in the slides
int 21h             ; not in the slides
ret                 ; not in the slides

; Expected output:
; B
; AX=0242h
