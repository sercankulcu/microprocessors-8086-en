; Reading keys with INT 16h AH = 00h until Enter; converting lowercase letters to uppercase and echoing them
; with INT 10h/0Eh. As in the slides, the keys O and k, then Enter.
; Source: Chapter 5.2 slides, "Trace: Read Keys and Echo".
; INPUT: "Ok\r"
org 100h
option nokeyword:<echo> ; not in the slides: in UASM ECHO is a directive, not a label
read:
mov ah, 0        ; wait for a key
int 16h          ; AH=scan code, AL=ASCII
cmp al, 0Dh      ; Enter?
je done
cmp al, 'a'
jb echo
cmp al, 'z'
ja echo
sub al, 20h      ; lowercase -> uppercase
echo:
mov ah, 0Eh
int 10h          ; write to the screen
jmp read
done:
ret

; Expected output:
; OK
