; Indirect access with BX: [BX] reads the byte BX points to, [0501h] reads a fixed address;
; AL = 25h + 17h = 3Ch, written to address [BX+2] = [0502h].
; Source: Chapter 2.2 8086 Registers, "Indirect Access with BX"

org 100h          ; not in the slides: .COM program
MOV BX, 0500h     ; BX = address
MOV AL, [BX]      ; AL = [0500h]
MOV DL, [0501h]   ; direct address
ADD AL, DL        ; AL = 25h + 17h
MOV [BX+2], AL    ; [0502h] = AL
RET               ; not in the slides: return to DOS

org 0500h                  ; not in the slides: the slide's memory contents are at DS:0500h
data db 25h, 17h, 00h, 9Ch ; not in the slides

; REGISTERS: AL DL BX
; MEMORY: data 4

; Expected output:
; AL=3Ch
; DL=17h
; BX=0500h
; data: 25h 17h 3Ch 9Ch
