; Six addressing modes: immediate, direct, indirect, based, base+index, base+index+d8.
; Slides 4.1 Memory Access, slide "Code Trace: Six Addressing Modes".
ORG 100h
MOV BX, OFFSET table
MOV SI, 2
MOV AH, 7          ; immediate
MOV AL, [table+1]  ; direct
MOV CL, [BX]       ; indirect
MOV CH, [BX+4]     ; based
MOV DL, [BX+SI]    ; base+index
MOV DH, [BX+SI+3]  ; + d8
RET
table DB 11h,22h,33h,44h,55h,66h

; REGISTERS: BX SI AX CX DX

; Expected output:
; BX=0116h
; SI=0002h
; AX=0722h
; CX=5511h
; DX=6633h
