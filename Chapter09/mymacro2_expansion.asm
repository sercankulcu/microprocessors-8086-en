; The expansion of MyMacro2 for AX = 2: label1 -> ??0000, label2 -> ??0001.
; CMP AX, 2 -> ZF = 1, JE ??0000; INC AX -> 3; ADD AX, 2 -> 5.
; Slides 9.1 "MyMacro2 Running".
ORG 100h
MOV  AX, 2       ; before MyMacro2
CMP  AX, 2       ; MyMacro2 starts
JE   ??0000
CMP  AX, 3
JE   ??0001
??0000:
INC  AX
??0001:
ADD  AX, 2       ; MyMacro2 ends
RET

; REGISTERS: AX

; Expected output:
; AX=0005h
