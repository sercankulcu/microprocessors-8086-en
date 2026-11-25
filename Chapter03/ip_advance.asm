; How does IP advance? The instructions are 3, 3, 1, 2, 1 bytes: B8 05 00 | BB 02 00 | 40 | 03 C3 | C3.
; IP advances by each instruction's length: 0100h, 0103h, 0106h, 0107h, 0109h.
; Source: Chapter 3.2 Assembly, "How Does IP Advance?"

code EQU 0100h  ; not in the slide: start of the code, for the MEMORY directive

ORG 100h
MOV AX, 5     ; 3 bytes
MOV BX, 2     ; 3 bytes
INC AX        ; 1 byte
ADD AX, BX    ; 2 bytes
RET           ; 1 byte

; REGISTERS: AX BX
; MEMORY: code 10

; Expected output:
; AX=0008h
; BX=0002h
; code: B8h 05h 00h BBh 02h 00h 40h 03h C3h C3h
