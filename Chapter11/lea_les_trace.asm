; Address or contents: LEA AX, [BX+DI+2] gives the effective address (data + 4), MOV AX, [BX+DI+2]
; gives the word there (3333h) (in the trace data is 0114h, EA is 0118h). LES DI, screen: DI = 0000h,
; ES = B800h; STOSB writes 'A' to B8000h, DI = 1.
; Source: Chapter 11 Instruction Encoding and String Instructions, "LEA and LES: Code Trace"
; REGISTERS: AX BX DI ES
; MEMORY: data 6

org 100h
lea bx, data        ; BX <- address
mov di, 2
lea ax, [bx+di+2]   ; AX <- EA
mov ax, [bx+di+2]   ; AX <- [EA]
les di, dword ptr screen ; far pointer  -- not in the slides: DWORD PTR (UASM does not accept a DW label with LES)
mov al, 'A'
stosb               ; ES:[DI] <- AL
ret
data   dw 1111h, 2222h, 3333h
screen dw 0000h, 0B800h

; Expected output:
; A
; AX=3341h
; BX=0114h
; DI=0001h
; ES=B800h
; data: 11h 11h 22h 22h 33h 33h
