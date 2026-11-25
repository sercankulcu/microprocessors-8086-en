; 32-bit addition on a 16-bit processor: ADD adds the low halves, ADC adds the high halves
; and the carry (CF) out of the low half.
; a = 0001FFFFh (131,071), b = 00030002h (196,610), a + b = 00050001h (327,681)
; Source: Chapter 1.1 Introduction, "32-Bit Addition: Code Trace"

org 100h
mov ax, 0FFFFh ; a: low half
mov dx, 0001h  ; a: high half
mov bx, 0002h  ; b: low half
mov cx, 0003h  ; b: high half
add ax, bx     ; low halves
adc dx, cx     ; high + CF
ret

; REGISTERS: DX AX CF

; Expected output:
; DX=0005h
; AX=0001h
; CF=0
