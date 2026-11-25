; Writing directly to video memory: B800:015Eh (row 2, column 15) <- 'A' and color DFh.
; Slides 4.1 Memory Access, slides "Example Program" and "Code Trace: Writing 'A' on the Screen" (same code).
; 'A' appears on the screen at row 2, column 15; the cell is also read back with MEMORY
; (when the program ends DS = B800h, so 'cell' shows B800:015Eh).
ORG 100h          ; for a .com program
MOV AX, 0B800h    ; AX = B800h
MOV DS, AX        ; DS = B800h
MOV CL, 'A'       ; CL = 41h
MOV CH, 11011111b ; CH = DFh
MOV BX, 15Eh      ; BX = 015Eh
MOV [BX], CX      ; B800:015E <- CX
RET               ; back to DOS
cell EQU 15Eh     ; not in the slides: a name for the MEMORY directive

; REGISTERS: DS CX BX
; MEMORY: cell 2

; Expected output:
;
;
;                A
; DS=B800h
; CX=DF41h
; BX=015Eh
; cell: 41h DFh
