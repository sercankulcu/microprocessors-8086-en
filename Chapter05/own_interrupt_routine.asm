; Installing our own interrupt routine at type 90h and calling it with INT 90h; the ISR writes '*' and returns with IRET.
; Source: Chapter 5.1 slides, "Our Own Interrupt Routine".
org 100h
mov ax, 0
mov es, ax          ; ES = 0: IVT segment
cli                 ; disable interrupts
mov word ptr es:[90h*4], offset isr  ; IP
mov word ptr es:[90h*4+2], cs       ; CS
sti                 ; enable interrupts
int 90h             ; our own interrupt
ret
isr:
mov ah, 0Eh
mov al, '*'
int 10h
iret                ; not RET!

; Expected output:
; *
