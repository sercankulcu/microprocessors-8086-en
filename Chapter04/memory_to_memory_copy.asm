; There is no memory-to-memory MOV: each byte is copied through AL (4 bytes with LOOP).
; Slides 4.1 Memory Access, slide "Code Trace: Block Copy Through a Register".
org 100h
mov si, offset src
mov di, offset dst
mov cx, 4
copy:
mov al, [si]         ; memory -> AL
mov [di], al         ; AL -> memory
inc si
inc di
loop copy
ret
src db 'ABCD'
dst db 4 dup('.')

; REGISTERS: SI DI CX AL
; MEMORY: dst 4

; Expected output:
; SI=0116h
; DI=011Ah
; CX=0000h
; AL=44h
; dst: 41h 42h 43h 44h
