; Installing an ISR for type 60h and passing the parameter in a register (AL = '#').
; Source: Chapter 5.1 slides, "Our Own Interrupt Routine: Code Trace".
; REGISTERS: SP IF
org 100h
mov ax, 0
mov es, ax           ; ES = 0: IVT
cli
mov word ptr es:[60h*4], offset isr
mov word ptr es:[60h*4+2], cs
sti
mov al, '#'
int 60h              ; our own interrupt
ret
isr:
mov ah, 0Eh
int 10h
iret

; Expected output:
; #
; SP=0000h
; IF=1
