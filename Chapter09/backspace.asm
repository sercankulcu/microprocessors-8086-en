; Reading with backspace handling: the key is read without echo (INT 16h), a letter taken into
; the buffer is echoed; on backspace DI moves back and 8, ' ', 8 are written to the screen.
; Input: A, b, backspace, c, Enter -> buffer 'A', 'c', 0; the screen shows Ac.
; Slides 9.2 "Backspace: Code Trace".
ORG  100h
LEA  DI, buf
get_key: MOV AH, 0
INT  16h         ; AL = key (no echo)
CMP  AL, 13      ; Enter?
JE   done
MOV  AH, 0Eh
CMP  AL, 8       ; backspace?
JNE  store
CMP  DI, OFFSET buf
JE   get_key     ; nothing to erase
DEC  DI
INT  10h         ; 8: cursor left
MOV  AL, ' '
INT  10h         ; blank the letter
MOV  AL, 8
INT  10h         ; left again
JMP  get_key
store: MOV [DI], AL
INC  DI
INT  10h         ; echo
JMP  get_key
done: MOV BYTE PTR [DI], 0
RET
buf  DB 6 DUP(?)

; INPUT: "Ab\x08c\r"
; MEMORY: buf 3

; Expected output:
; Ac
; buf: 41h 63h 00h
