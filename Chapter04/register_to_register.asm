; Copying an address from one register to another: DI = SI, both point to the same cell.
; Slides 4.1 Memory Access, slide "Copying One Register into Another".
ORG 100h       ; not in the slides
MOV SI, 3000h  ; SI = address
MOV DI, SI     ; DI = SI
MOV AL, [SI]   ; DS:3000h
MOV [DI+1], AL ; DS:3001h
RET            ; not in the slides
ORG 3000h      ; not in the slides: the memory contents from the trace (DS:3000h = 5Ah)
cell DB 5Ah, 0   ; not in the slides

; REGISTERS: SI DI AL
; MEMORY: cell 2

; Expected output:
; SI=3000h
; DI=3000h
; AL=5Ah
; cell: 5Ah 5Ah
