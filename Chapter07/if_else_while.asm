; Assembly version of the if / else and while patterns: jump on the OPPOSITE of the condition.
; if (AX == BX) DX = 1; else DX = 2;  while (CX > 0) { DX += CX; CX--; }  ->  DX = 5.
; Slides: Chapter 7 Flow Control, slides "if / else Pattern" (general pattern) and
; "if / else and while: Code Trace" (this program).
ORG  100h        ; not in the slides: .COM program
MOV  AX, 12
MOV  BX, 30
CMP  AX, BX
JNE  not_eq      ; the OPPOSITE of the condition
MOV  DX, 1       ; block A: AX = BX
JMP  after
not_eq: MOV DX, 2 ; block B: AX <> BX
after: MOV CX, 2  ; while (CX > 0)
top: CMP CX, 0
JBE  done        ; CX <= 0 -> leave
ADD  DX, CX      ; body
DEC  CX
JMP  top
done: RET

; REGISTERS: AX BX CX DX ZF

; Expected output:
; AX=000Ch
; BX=001Eh
; CX=0000h
; DX=0005h
; ZF=1
