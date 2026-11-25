; Swapping the INT 3 vector with XCHG while saving the old one, calling our own ISR, and
; restoring the old vector. The ISR preserves the AX it uses with PUSH/POP.
; In the slides the old vector is emu8086's F000:1003h; in this test environment the default
; routines are at F000:n*4, so the old vector comes out as F000:000Ch.
; Source: Chapter 5.1 slides, "Save and Restore the Vector: Code Trace".
; REGISTERS: AX BX
; MEMORY: old_vec 4
org 100h
xor ax, ax
mov es, ax          ; ES = 0: IVT
mov ax, offset isr3
xchg ax, es:[3*4]   ; new IP <-> old
mov old_vec, ax
mov ax, cs
xchg ax, es:[3*4+2] ; new CS <-> old
mov old_vec+2, ax
mov ax, 1234h
int 3               ; our ISR
mov bx, old_vec
mov es:[3*4], bx    ; restore
mov bx, old_vec+2
mov es:[3*4+2], bx
ret
isr3: push ax
mov ax, 0E21h       ; AH=0Eh, AL='!'
int 10h
pop ax
iret
old_vec dw ?, ?

; Expected output:
; !
; AX=1234h
; BX=F000h
; old_vec: 0Ch 00h 00h F0h
