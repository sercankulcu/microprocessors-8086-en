; The parameter trap: when MyMacro BX, AX, 0 expands, the first MOV AX, BX corrupts the AX
; that the second line reads; 1111h is lost, AX = BX = 2222h. Slides 9.1 "The Parameter Trap".
ORG 100h
MOV  AX, 1111h
MOV  BX, 2222h
MOV  AX, BX  ; MyMacro BX,AX,0
MOV  BX, AX  ; p2 = AX (corrupted!)
MOV  CX, 0
RET

; REGISTERS: AX BX CX

; Expected output:
; AX=2222h
; BX=2222h
; CX=0000h
