; An EQU constant is built into the instruction and takes no memory; if v is DB 5 it is read from memory.
; Slides 4.2 Variables, slides "Code Trace: EQU Is Built into the Instruction" and "Constants (EQU)"
; (the three MOVs on the second one are the first three instructions of this program).
k      EQU 5
ROWLEN EQU 80
ORG 100h
MOV AX, k        ; MOV AX, 5
MOV BX, ROWLEN*2 ; MOV BX, 160
MOV CL, k+1      ; MOV CL, 6
MOV DL, v        ; from memory
RET
v DB 5           ; takes 1 byte

; REGISTERS: AX BX CL DL

; Expected output:
; AX=0005h
; BX=00A0h
; CL=06h
; DL=05h
