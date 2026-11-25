; AX accumulator: adding AX to itself doubles it (5 + 5 = 0Ah).
; The program ends with INT 21h / 4Ch; because AH = 4Ch was written, AX = 4C0Ah.
; Source: Chapter 2.2 8086 Registers, "AX — Accumulator"

org 100h       ; not in the slides: .COM program
ADD AX, AX     ; AX = AX + AX
MOV AX, 0005h
ADD AX, AX     ; AX = 000Ah
MOV AH, 4Ch    ; DOS: exit
INT 21h

; REGISTERS: AX AL

; Expected output:
; AX=4C0Ah
; AL=0Ah
