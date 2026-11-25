; BP is paired with SS by default: in an .EXE with a separate stack segment [bp] reads the stack, not the data.
; Slides 4.1 Memory Access, slide "Code Trace: Reaching Data Through BP".
; The trace on the slide: DS = 0710h, SS = 0711h; AL = 00h (stack), BL = CL = 44h ('D').
; AL's [bp] value is not visible in AX because MOV AX, 4C00h overwrites it at the end (AL is 00h again).
.model small            ; not in the slides: so that the checker builds an .EXE
data segment
pad db 3 dup(0)
x db 'D'
data ends
stk segment stack
dw 64 dup(0)
stk ends
code segment
assume cs:code, ds:data, ss:stk
start:
mov ax, data
mov ds, ax
mov bp, offset x
mov al, [bp]         ; reads SS:BP!
mov bl, ds:[bp]      ; DS:BP
mov si, offset x
mov cl, [si]         ; DS:SI
mov ax, 4C00h
int 21h
code ends
end start

; REGISTERS: DS SS BP SI BL CL

; Expected output:
; DS=0710h
; SS=0711h
; BP=0003h
; SI=0003h
; BL=44h
; CL=44h
