; A simplified equivalent of the GET_STRING read loop (DX = 4): at most DX - 1 = 3
; characters are taken and the buffer ends with 0. The user types "Ecem"; the 4th letter is not read.
; Slides 9.2 "GET_STRING Logic: Code Trace".
; As on the slide, buf = 011Dh; after three letters DI = 0120h.
ORG  100h        ; not on the slide
LEA  DI, buf     ; buffer address
MOV  DX, 4       ; buffer size
get_key: CMP DX, 1   ; keep 1 byte for the 0
JBE  done
MOV  AH, 01h
INT  21h         ; AL = key (echoed)
CMP  AL, 13      ; Enter?
JE   done
MOV  [DI], AL    ; store in buffer
INC  DI
DEC  DX
JMP  get_key
done: MOV BYTE PTR [DI], 0
RET
buf  DB 4 DUP(?)

; INPUT: "Ecem\r"
; REGISTERS: DI DX AL
; MEMORY: buf 4

; Expected output:
; Ece
; DI=0120h
; DX=0001h
; AL=65h
; buf: 45h 63h 65h 00h
