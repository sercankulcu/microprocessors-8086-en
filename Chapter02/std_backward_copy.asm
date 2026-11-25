; Backward copy with STD: in an overlapping area where the destination is ahead of the source,
; copy from the end to the start. "KLMN" shifts one place right: KKLMN. (With CLD it would be KKKKK.)
; Source: Chapter 2.2 8086 Registers, "Backward Copy with STD: Code Trace"

org 100h
mov si, offset arr+3 ; source
mov di, offset arr+4 ; destination
mov cx, 4
std                  ; DF = 1
rep movsb
cld
ret
arr db 'KLMN', 0

; REGISTERS: SI DI CX DF
; MEMORY: arr 5

; Expected output (arr is at 010Eh):
; SI=010Dh
; DI=010Eh
; CX=0000h
; DF=0
; arr: 4Bh 4Bh 4Ch 4Dh 4Eh
