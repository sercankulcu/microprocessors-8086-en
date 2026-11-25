; Getting the day of the week (AL = 0...6) with INT 21h AH = 2Ah and printing the day name
; from a table of 4-byte records. The test environment's date is 1 January 2026, Thursday (AL = 4).
; Source: Chapter 5.2 slides, "Date and Time" and "Print the Day Name: Code Trace".
org 100h
mov ah, 2Ah
int 21h          ; AL = 0...6
mov ah, 0
mov bl, 4
mul bl           ; AX = AL * 4
mov dx, offset days
add dx, ax
mov ah, 09h
int 21h
ret
days db 'Sun$Mon$Tue$Wed$'
     db 'Thu$Fri$Sat$'

; Expected output:
; Thu
