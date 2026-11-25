; DX:AX with MUL: a 16-bit MUL puts its result in DX:AX (1234h x 0100h = 00123400h), an 8-bit
; MUL puts it in AX (FFh x 2 = 01FEh; DX is unchanged). Then DX becomes a port number:
; AL = FEh is sent to port 03F8h (COM1).
; Source: Chapter 2.2 8086 Registers, "DX:AX with MUL"

org 100h        ; not in the slides: .COM program
MOV AX, 1234h
MOV BX, 0100h
MUL BX          ; DX:AX = AX*BX
MOV AX, 00FFh
MOV BL, 2
MUL BL          ; AX = AL*BL
MOV DX, 03F8h   ; port address
OUT DX, AL      ; write to port
RET             ; not in the slides: return to DOS

; REGISTERS: AX BX DX CF OF

; Expected output (port 03F8h = 1016):
; OUT 1016 <- FEh
; AX=01FEh
; BX=0102h
; DX=03F8h
; CF=1
; OF=1
