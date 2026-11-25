; A pointer in memory: ADD p, 2 advances the pointer, and each use first loads it into BX.
; Slides 4.2 Variables, slide "Code Trace: A Pointer in Memory".
ORG 100h
MOV BX, p          ; contents of p
MOV AL, [BX]       ; arr[0]
ADD p, 2           ; advance
MOV BX, p
MOV AH, [BX]       ; arr[2]
RET
arr DB 'KAYA'
p   DW arr         ; address

; REGISTERS: AX BX
; MEMORY: p 2

; Expected output:
; AX=594Bh
; BX=0114h
; p: 14h 01h
