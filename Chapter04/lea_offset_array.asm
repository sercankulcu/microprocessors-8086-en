; LEA SI, a[BX] computes the address at run time; OFFSET a is a constant, BX is added separately.
; Slides 4.2 Variables, slide "Code Trace: LEA a[BX] vs. OFFSET a".
ORG 100h
MOV BX, 2
LEA SI, a[BX]      ; SI = a + BX
MOV DI, OFFSET a   ; fixed address
ADD DI, BX         ; add by hand
MOV AL, [SI]
INC BX
LEA SI, a[BX]      ; new address
MOV AH, [SI]
RET
a DB 'ABCD'

; REGISTERS: AX BX SI DI

; Expected output:
; AX=4443h
; BX=0003h
; SI=0119h
; DI=0118h
