; Output without the BIOS: writing straight to the B800h video memory. Each cell is 2 bytes
; (character, attribute); cell (1,4) is at (1*80+4)*2 = 00A8h. Then REP STOSW fills the first 3 cells with '.'.
; The first example in the slides fills the whole screen with CX = 2000; the code trace uses the same code with CX = 3.
; The screen shows '...' on the first row and 'A' in cell (1,4); the registers are checked too.
; Source: Chapter 5.2 slides, "Direct Video Memory" and "B800h Video Memory: Code Trace".
; REGISTERS: ES DI AX CX
org 100h
mov ax, 0B800h
mov es, ax
mov di, (1*80+4)*2  ; 00A8h
mov ax, 4E41h
mov es:[di], ax
xor di, di
mov ax, 072Eh
mov cx, 3           ; first 3 cells
cld
rep stosw
ret

; Expected output:
; ...
;     A
; ES=B800h
; DI=0006h
; AX=072Eh
; CX=0000h
