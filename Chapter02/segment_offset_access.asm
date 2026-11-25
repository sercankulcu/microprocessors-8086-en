; Access with segment:offset: 2000h:0010h and 2001h:0000h are the same physical byte
; (20010h). With DS = 2001h, [FFFFh] is the last byte of the segment: 3000Fh.
; Source: Chapter 2.1 8086 Architecture, "Code Trace: Access with Segment:Offset"

cell EQU 0000h          ; not in the slides: the name of 2001:0000 for the MEMORY directive

org 100h                 ; not in the slides: .COM program
mov ax, 2000h
mov ds, ax          ; DS = 2000h
mov bx, 0010h
mov byte ptr [bx], 41h
mov ax, 2001h
mov ds, ax          ; +16 bytes
mov bx, 0000h
mov al, [bx]        ; same byte
mov si, 0FFFFh
mov ah, [si]        ; last byte
ret                      ; not in the slides: return to DOS

; REGISTERS: AL DS
; MEMORY: cell 1

; Expected output:
; AL=41h
; DS=2001h
; cell: 41h
