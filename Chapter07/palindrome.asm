; Find out whether a string is a palindrome by comparing from both ends.
; Slides: Chapter 7 Flow Control, slides "Palindrome: Setup" and "Palindrome: Comparison".
option nokeyword:<str> ; not in the slides: UASM takes str for the 286 instruction STR
org 100h
jmp start
msg:
str db '123321'
str_size = $ - msg     ; = 6
db 0Dh,0Ah,'$'
start:
mov ah, 9              ; print up to '$'
mov dx, offset str
int 21h
lea di, str            ; DI = address of str
mov si, di
add si, str_size       ; SI = last + 1
dec si                 ; SI = last character
mov cx, str_size
cmp cx, 1              ; a single character?
je is_palindrome       ; a single character is a palindrome
shr cx, 1              ; CX = length / 2
next_char:
mov al, [di]          ; character at the start
mov bl, [si]          ; character at the end
cmp al, bl
jne not_palindrome    ; different: not a palindrome
inc di                ; one forward from the start
dec si                ; one back from the end
loop next_char
is_palindrome:
mov ah, 9             ; print "palindrome!"
mov dx, offset msg1
int 21h
jmp stop
not_palindrome:
mov ah, 9             ; print "not palindrome!"
mov dx, offset msg2
int 21h
stop:
ret
msg1 db "palindrome!$"
msg2 db "not palindrome!$"

; REGISTERS: CX DI SI

; Expected output:
; 123321
; palindrome!
; CX=0000h
; DI=0105h
; SI=0104h
