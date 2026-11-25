; AX = AH : AL. Writing to an 8-bit half does not change the other half; the carry of an 8-bit
; addition goes to CF, not to AH (AX = 1200h, CF = 1). In a 16-bit addition the carry
; moves into AH: 12FFh + 1 = 1300h, CF = 0.
; Source: Chapter 2.2 8086 Registers, "AX = AH : AL"

org 100h        ; not in the slides: .COM program
MOV AX, 1234h   ; AH=12h, AL=34h
MOV AL, 0FFh    ; low half only
ADD AL, 1       ; 8-bit add
MOV AX, 12FFh
ADD AX, 1       ; 16-bit add
RET             ; not in the slides: return to DOS

; REGISTERS: AX AH AL CF

; Expected output:
; AX=1300h
; AH=13h
; AL=00h
; CF=0
