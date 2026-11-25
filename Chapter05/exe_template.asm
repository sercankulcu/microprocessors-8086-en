; .EXE program template: .model small, separate stack/data/code segments, DS set up
; from @data, and exit with INT 21h AH = 4Ch.
; Source: Chapter 5.2 slides, "COM and EXE Templates" and "EXE Template: Code Trace".
.model small
.stack 100h
.data
msg db 'Welcome$'
.code
start:
mov ax, @data
mov ds, ax      ; set up DS!
mov dx, offset msg
mov ah, 09h
int 21h
mov ax, 4C00h
int 21h
end start

; Expected output:
; Welcome
