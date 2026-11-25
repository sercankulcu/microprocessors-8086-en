; Array length with $ (n EQU $ - arr) and finding the largest element with LOOP (JAE: unsigned).
; Slides 4.2 Variables, slide "Code Trace: Size with $, Maximum with a Loop".
ORG 100h
JMP start
arr DB 12, 47, 5, 31
n EQU $ - arr      ; 4
big DB ?
start:
MOV CX, n          ; CX = 4
MOV SI, 0
MOV AL, arr[SI]    ; first guess
check:
CMP AL, arr[SI]
JAE skip           ; AL >= element
MOV AL, arr[SI]    ; new guess
skip:
INC SI
LOOP check
MOV big, AL
RET

; REGISTERS: AL CX SI
; MEMORY: big 1

; Expected output:
; AL=2Fh
; CX=0000h
; SI=0004h
; big: 2Fh
