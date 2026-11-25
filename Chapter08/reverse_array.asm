; Reversing an array with the stack: 'A', 'B', 'C' are pushed in order, popped in reverse order and printed.
; Slides: Chapter 8 The Stack, slide "Example: Reversing an Array".
ORG  100h
MOV  SI, OFFSET msg
MOV  CX, 3
put: MOV  AL, [SI]
     PUSH AX       ; save the char
     INC  SI
     LOOP put
MOV  CX, 3
prt: POP  DX       ; DL = char
     MOV  AH, 2
     INT  21h      ; print DL
     LOOP prt
RET
msg DB 'ABC'     ; 0117h

; Since msg is at 0117h, SI = 011Ah after the loop.
; REGISTERS: SI DX
; MEMORY: msg 3
; Expected output:
; CBA
; SI=011Ah
; DX=0041h
; msg: 41h 42h 43h
