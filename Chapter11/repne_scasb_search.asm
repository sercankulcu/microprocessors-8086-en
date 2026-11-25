; Search for a character with REPNE SCASB: in 'pushing' the 'h' is found at the 4th comparison
; (ZF = 1, CX = 3). DI points one past the match; DEC DI and subtracting the start give
; DI = 3 (the index of 'h' counting from 0).
; Source: Chapter 11 Instruction Encoding and String Instructions, "Trace: REPNE SCASB"
; REGISTERS: DI CX ZF

org 100h
cld
lea di, msg
mov cx, 7          ; length
mov al, 'h'        ; target
repne scasb        ; search
jne not_found
dec di             ; match position
sub di, offset msg
not_found:
ret
msg db 'pushing'

; Expected output:
; DI=0003h
; CX=0003h
; ZF=0
