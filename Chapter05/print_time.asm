; Getting the system time (binary) with INT 21h AH = 2Ch and printing HH:MM, splitting each value into two digits with AAM.
; The test environment's time is 12:00:00.
; Source: Chapter 5.2 slides, "Trace: Print the Time".
org 100h
mov ah, 2Ch       ; get the system time
int 21h           ; CH=hour CL=minute
mov al, ch
call print2
mov dl, ':'
mov ah, 02h
int 21h
mov al, cl
call print2
ret
print2:           ; AL (0-99) -> 2 digits
aam               ; AH=tens AL=ones
add ax, 3030h     ; ASCII
mov bx, ax
mov dl, bh
mov ah, 02h
int 21h
mov dl, bl
int 21h
ret

; Expected output:
; 12:00
