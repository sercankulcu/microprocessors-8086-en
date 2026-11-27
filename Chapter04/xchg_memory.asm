; XCHG register <-> memory, compared with a swap using three MOVs (helper register AX) instead of XCHG.
; Slides 4.1 Memory Access, slide "Code Trace: Swapping with XCHG"
; (the three-MOV swap is the same as the one on the "XCHG Rules" slide).
ORG 100h
MOV SI, OFFSET num
MOV AL, 5Ah
XCHG AL, [SI]      ; AL <-> [SI]
MOV CX, 1111h
MOV DX, 2222h
MOV AX, CX         ; backup
MOV CX, DX
MOV DX, AX         ; swapped
XCHG CX, DX        ; one instr.
RET
num DB 0A5h

; REGISTERS: SI AX CX DX
; MEMORY: num 1

; Expected output:
; SI=0116h
; AX=1111h
; CX=1111h
; DX=2222h
; num: 5Ah
