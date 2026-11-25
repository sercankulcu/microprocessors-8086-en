; LEA gives the address, MOV gives the contents: LEA AX, [BX+DI+2] -> AX = 0016h, MOV AX, [BX+DI+2]
; -> AX = [0016h]. LES DI, screen loads the far pointer (DI = 0000h, ES = B800h); STOSB writes 'A'
; to the top-left corner of the screen (B8000h). LDS SI, screen loads the same pointer into DS:SI
; (SI = 0000h, DS = B800h); LODSB reads the 'A' back from the corner: AL = 41h, SI = 0001h.
; The 'A' is visible on the screen.
; Source: Chapter 11 Instruction Encoding and String Instructions, "LEA, LDS, LES"
; REGISTERS: AL BX DI ES SI DS

ORG 100h           ; not in the slides
mov bx, 0010h
mov di, 0004h
lea ax, [bx+di+2]  ; AX = 0016h (address)
mov ax, [bx+di+2]  ; AX = [0016h] (contents)

; video memory: B800:0000
; not in the slides: DWORD PTR (UASM does not accept a DW label with LES/LDS); the slide has "les di, screen"
les di, dword ptr screen ; DI=0000h ES=B800h
mov al, 'A'
stosb             ; 'A' in the corner
; not in the slides: DWORD PTR (UASM does not accept a DW label with LES/LDS); the slide has "lds si, screen"
lds si, dword ptr screen ; SI=0000h DS=B800h
lodsb             ; AL = 'A' (corner)
ret
screen dw 0000h, 0B800h

; Expected output:
; A
; AL=41h
; BX=0010h
; DI=0001h
; ES=B800h
; SI=0001h
; DS=B800h
