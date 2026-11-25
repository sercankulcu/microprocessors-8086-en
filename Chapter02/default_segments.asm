; Default segments: the same offset (0010h) goes to three different bytes.
; [bx] -> DS:0010 = 20010h, [bp] -> SS:0010 = 07010h, es:[bx] -> ES:0010 = 30010h
; (in a .COM program SS = CS = 0700h)
; Source: Chapter 2.1 8086 Architecture, "Default Segments: Code Trace"

cell EQU 0010h          ; not in the slides: the name of DS:0010 for the MEMORY directive

org 100h
mov ax, 2000h
mov ds, ax
mov ax, 3000h
mov es, ax
mov bx, 0010h
mov bp, 0010h
mov byte ptr [bx], 11h    ; DS
mov byte ptr [bp], 22h    ; SS
mov byte ptr es:[bx], 33h ; ES
mov al, [bx]              ; DS
mov ah, [bp]              ; SS
ret

; REGISTERS: AX DS ES SS
; MEMORY: cell 1

; Expected output:
; AX=2211h
; DS=2000h
; ES=3000h
; SS=0700h
; cell: 11h
