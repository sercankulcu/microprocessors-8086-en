; Two digits with AAM and PUTC: 58 -> AH = 5, AL = 8 -> '5', '8'. Because PUTC preserves AX,
; both digits are written without copying them to another register.
; Slides 9.2 "Printing Two Digits: Code Trace".
ORG  100h
MOV  AL, 58
AAM              ; AH = 5, AL = 8
ADD  AX, 3030h   ; '5', '8'
PUSH AX          ; PUTC AH expansion
MOV  AL, AH
MOV  AH, 0Eh
INT  10h
POP  AX          ; AX back: 3538h
PUSH AX          ; PUTC AL expansion
MOV  AL, AL
MOV  AH, 0Eh
INT  10h
POP  AX
RET

; REGISTERS: AX

; Expected output:
; 58
; AX=3538h
