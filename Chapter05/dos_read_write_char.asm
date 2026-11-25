; Reading a character with echo (INT 21h AH = 01h), then writing CR, LF and the next letter with AH = 02h.
; Source: Chapter 5.2 slides, "Trace: AH = 01h / 02h".
; INPUT: "a"
org 100h
mov ah, 01h      ; read + echo
int 21h          ; AL = character
mov bl, al       ; save it
mov ah, 02h      ; write character
mov dl, 0Dh      ; CR: carriage return
int 21h
mov dl, 0Ah      ; LF: line feed
int 21h
inc bl           ; next letter
mov dl, bl
int 21h
ret

; Expected output:
; a
; b
