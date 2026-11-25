; Print a 0-terminated string character by character with BIOS teletype (INT 10h, AH = 0Eh).
; Slides: Chapter 7 Flow Control, slide "Printing Hello on the Screen".
org     100h
jmp     start
msg db 'Hello', 0
start:
mov     si, 0          ; source index = 0
next_char:
mov     al, msg[si]    ; get the character
cmp     al, 0          ; compare with 0
je      stop           ; stop printing if 0
mov     ah, 0eh        ; teletype function
int     10h            ; print the character in AL
inc     si             ; next character
jmp     next_char      ; back to the start
stop:
ret

; REGISTERS: SI

; Expected output:
; Hello
; SI=0005h
