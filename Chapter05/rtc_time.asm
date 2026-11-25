; Reading the RTC time (packed BCD) with INT 1Ah AH = 02h and printing it as HH:MM:ss; the high
; digit of a BCD byte is taken with SHR, the low digit with AND 0Fh. colon falls through into putbcd.
; The test environment's RTC time is 12:00:00 (the slides' example is 14:35:07).
; Source: Chapter 5.2 slides, "Trace: Print the RTC Time".
org 100h
mov ah, 02h
int 1Ah          ; CH=hour CL=min DH=sec
jc  done         ; CF=1: time could not be read
mov bl, cl       ; save the minutes
mov cl, 4        ; SHR shift count
mov bh, ch
call putbcd      ; "14"
mov bh, bl
call colon       ; ":35"
mov bh, dh
call colon       ; ":07"
done: ret
colon: mov dl, ':'
mov ah, 02h
int 21h
putbcd:          ; BH = packed BCD
mov dl, bh
shr dl, cl       ; high digit
add dl, 30h      ; ASCII digit
mov ah, 02h
int 21h
mov dl, bh
and dl, 0Fh      ; low digit
add dl, 30h
int 21h
ret

; Expected output:
; 12:00:00
