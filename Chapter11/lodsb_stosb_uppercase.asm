; Convert a string to upper case in place with LODSB + STOSB: AND AL, 0DFh clears bit 5.
; 'micro' -> 'MICRO'. In a .COM program ES = DS, so ES:DI points at the same string.
; In the trace the text is at 0110h; at the end SI = DI = 0115h.
; Source: Chapter 11 Instruction Encoding and String Instructions, "Trace: LODSB / STOSB"
; REGISTERS: CX SI DI
; MEMORY: msg 5

org 100h
cld               ; DF = 0: forward
lea si, msg
mov di, si        ; write to the same place
mov cx, 5
next_ch:
lodsb             ; AL = [SI], SI++
and al, 0DFh      ; upper case
stosb             ; [DI] = AL, DI++
loop next_ch
ret
msg db 'micro'

; Expected output:
; CX=0000h
; SI=0115h
; DI=0115h
; msg: 4Dh 49h 43h 52h 4Fh
