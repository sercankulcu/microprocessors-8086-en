; LED display (port 199): the word is shown as a signed decimal number. 1234 = 04D2h,
; -5678 = E9D2h, then 0, 1, 2, ... are written in an endless loop (the HLT below is never reached).
; Source: Chapter 10.2 Device Control, "LED Display Program"
; LIMIT: 13
; REGISTERS: AX

#start=led_display.exe#
ORG 100h           ; not on the slide
mov ax, 1234
out 199, ax
mov ax, -5678
out 199, ax
; write the port in an endless loop:
mov ax, 0
x1:
out 199, ax
inc ax
jmp x1
hlt              ; never runs

; Expected output:
; OUT 199 <- 04D2h
; OUT 199 <- E9D2h
; OUT 199 <- 0000h
; OUT 199 <- 0001h
; OUT 199 <- 0002h
; AX=0003h
