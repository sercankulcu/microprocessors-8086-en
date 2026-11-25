; INT 10h: video mode (00h), cursor (02h), character with attribute (09h, cursor does not advance) and
; teletype (0Eh, cursor advances). 'A' is written over the first star: the screen shows AB*.
; Source: Chapter 5.2 slides, "Trace: INT 10h" (and "Video Mode and Screen").
org 100h
mov ax, 0003h    ; AH=00h, AL=03h
int 10h          ; screen is cleared
mov ah, 02h      ; set cursor position
mov bh, 0        ; page 0
mov dx, 0104h    ; DH=1, DL=4
int 10h
mov ah, 09h      ; character + attribute
mov al, '*'
mov bl, 4Eh      ; yellow on red
mov cx, 3        ; 3 times
int 10h          ; cursor does not advance!
mov ah, 0Eh      ; teletype
mov al, 'A'
int 10h          ; cursor advances
mov al, 'B'
int 10h
ret

; Expected output:
;
;     AB*
