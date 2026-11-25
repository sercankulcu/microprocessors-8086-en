; Block operations with the REP prefix: REP MOVSB copies a 100-byte block; REP STOSW fills the
; video memory (B800:0000, 80 x 25 = 2000 words) with blank + attribute 07h. At the end CX = 0,
; DI = 2000 x 2 = 0FA0h. The screen fills with blanks (looks empty).
; Source: Chapter 11 Instruction Encoding and String Instructions, "REP Prefixes" (two parts)
; REGISTERS: CX DI ES
; MEMORY: dst 4

ORG 100h          ; not in the slides
; copy a 100-byte block
cld
lea si, src
lea di, dst
mov cx, 100
rep movsb

; fill the screen with blanks
mov ax, 0B800h
mov es, ax
xor di, di
mov ax, 0720h   ; ' ' + attribute
mov cx, 2000    ; 80 x 25
rep stosw
ret                    ; not in the slides
src db 100 dup('K')    ; not in the slides
dst db 100 dup('.')    ; not in the slides

; Expected output:
; CX=0000h
; DI=0FA0h
; ES=B800h
; dst: 4Bh 4Bh 4Bh 4Bh
