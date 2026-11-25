; AAA: adjust after unpacked BCD addition. 9 + 5 = 0Eh -> AH = 1, AL = 4: "14".
; Source: Chapter 6 slides, "AAA: Adjust After Addition".
; REGISTERS: AX
org 100h        ; not in the slides: .COM program
; first number '9':
mov     ah, 09h
; second number '5':
mov     al, 05h
; al = al + ah = 09h + 05h = 0eh
add     al, ah
; clear tens byte of bcd
xor     ah, ah
; adjust result to bcd form, ah = 1, al = 4 -> '14'
aaa
; --- print the result (extra) ---
or      ax, 3030h   ; convert to ASCII
mov     bl, al      ; save '4'
mov     al, ah      ; '1'
mov     ah, 0Eh
int     10h
mov     al, bl
int     10h
ret

; Expected output:
; 14
; AX=0E34h
