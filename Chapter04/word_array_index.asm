; In a word array the index is a distance in bytes: arr[1] (SI = 1) reads the middle of two elements;
; the correct way is SI = index x 2 (shl si, 1).
; Slides 4.1 Memory Access, slide "Code Trace: The Word-Array Index Bug".
org 100h
mov si, 1            ; index 1
mov ax, arr[si]      ; BUG!
shl si, 1            ; index x 2
mov bx, arr[si]      ; arr[1]
mov si, 2            ; index 2
shl si, 1            ; SI = 4
mov cx, arr[si]      ; arr[2]
ret
arr dw 1234h, 5678h, 9ABCh

; REGISTERS: AX BX CX SI

; Expected output:
; AX=7812h
; BX=5678h
; CX=9ABCh
; SI=0004h
