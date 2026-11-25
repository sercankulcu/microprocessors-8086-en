; Thermostat (port 125 temperature, port 127 heater): if the temperature is below 60 C the
; heater is switched on (1), above 80 C it is switched off (0), in between it is left alone.
; Signed comparison (JL/JLE/JG). Port 125 returns 55, 70, 85 in turn (then always 85).
; Endless loop.
; Source: Chapter 10.2 Device Control, "Thermometer Program"
; PORT 125: 55 70 85
; LIMIT: 24
; REGISTERS: AL DS

option nokeyword:<low high>   ; not on the slide: in UASM LOW/HIGH are operator names, not labels
ORG 100h      ; not on the slide
; make DS equal to CS:
mov ax, cs
mov ds, ax
start:
in  al, 125
cmp al, 60
jl  low
cmp al, 80
jle ok
jg  high
low:
mov al, 1
out 127, al   ; heater on
jmp ok
high:
mov al, 0
out 127, al   ; heater off
ok:
jmp start     ; endless loop

; Expected output:
; OUT 127 <- 01h
; OUT 127 <- 00h
; AL=00h
; DS=0700h
