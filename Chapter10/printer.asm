; Printer: first a form feed (12), then the 59 (3Bh) characters in msg are sent to the printer
; one by one with INT 21h / AH = 05h; the length offset msg_end - offset msg is computed at
; assembly time. What goes to the printer appears in the test environment as PRINTER: lines.
; 0Ah, 0Dh is a single line end; a lone CR (13) also counts as a new line (on paper it returns
; to the start of the line and overprints); form feed (0Ch) and tab (09h) stay in the line as
; raw characters.
; Source: Chapter 10.2 Device Control, "Printer Data" and "Printer Program"

org 100h
jmp start
msg db "Hello, Printer!", 0Ah, 0Dh
    db "***************"
    db 13, 9    ; CR and horizontal tab (HT)
    db "Have a nice printing day!"
msg_end db 0
msg2 db "press any key to eject the page.$"

start:
mov dl, 12      ; form feed: new page
mov ah, 5
int 21h
mov si, offset msg
mov cx, offset msg_end - offset msg
print:
mov dl, [si]
mov ah, 5       ; DOS printer function
int 21h
inc si          ; next character
loop print
ret             ; not on the slide

; Expected output:
; PRINTER: Hello, Printer!
; PRINTER: ***************
; PRINTER: 	Have a nice printing day!
