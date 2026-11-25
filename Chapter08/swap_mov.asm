; Swap using a third register (CX): three MOVs, no stack.
; Slides: Chapter 8 The Stack, slide "Swap Methods" (method 2).
ORG 100h          ; not in the slides: .COM program
MOV AX, 1212h     ; not in the slides: initial values
MOV BX, 3434h     ; not in the slides: initial values
MOV CX, AX
MOV AX, BX
MOV BX, CX
RET               ; not in the slides: return to DOS

; REGISTERS: AX BX CX
; Expected output:
; AX=3434h
; BX=1212h
; CX=1212h
