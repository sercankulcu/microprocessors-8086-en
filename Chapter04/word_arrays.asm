; In a DW array the index of element i is 2 x i; w[1] reads from the middle of two elements.
; Slides 4.2 Variables, slide "Code Trace: Indexing a DW Array".
ORG 100h
MOV AX, w[0]   ; element 1
MOV BX, w[2]   ; element 2
MOV SI, 4
MOV CX, w[SI]  ; element 3
MOV DX, w[1]   ; careful!
RET
w DW 1111h, 2222h, 3333h

; REGISTERS: AX BX CX DX

; Expected output:
; AX=1111h
; BX=2222h
; CX=3333h
; DX=2211h
