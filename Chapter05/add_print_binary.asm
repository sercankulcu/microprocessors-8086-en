; Computing 5 + 10 - 1 = 14 and printing the result in binary, bit by bit, with TEST and SHL.
; Source: Chapter 5.2 slides, "Add, Subtract and Print the Result" (two slides) and
; "Code Trace: Calculation" / "Code Trace: Loop".
; INPUT: " "
org 100h
mov al, 5       ; 00000101b
mov bl, 10      ; 0Ah = 00001010b
; 5 + 10 = 15 = 0Fh = 00001111b
add bl, al
; 15 - 1 = 14 = 0Eh = 00001110b
sub bl, 1
mov cx, 8       ; print the result in binary
print:
mov ah, 2   ; print function
mov dl, '0'
test bl, 10000000b  ; test the top bit
jz zero
mov dl, '1'
zero:
int 21h
shl bl, 1
loop print
; print the binary suffix b
mov dl, 'b'
int 21h
; wait for a key press
mov ah, 0
int 16h
ret

; Expected output:
; 00001110b
