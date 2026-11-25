; LOCK XCHG as an indivisible read-modify-write: if the semaphore is free (0) it is taken and
; released after the critical section. In the trace the flag is at 0110h; XCHG gives AL the
; old value (0).
; Source: Chapter 10.1 8086 Pins, "Semaphore with LOCK: Code Trace"
; REGISTERS: AL BX ZF
; MEMORY: flag 1

org 100h
mov bx, offset flag
retry: mov al, 1
lock xchg al, [bx]   ; read + write
cmp al, 0            ; was it free?
jne retry            ; busy: retry
; ... critical section ...
mov byte ptr [bx], 0 ; release
ret
flag db 0

; Expected output:
; AL=00h
; BX=0110h
; ZF=1
; flag: 00h
