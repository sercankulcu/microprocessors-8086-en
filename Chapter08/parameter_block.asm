; Parameter block: BX carries the address of the block; calc writes the result a * b + c = 12 * 7 + 5 = 89 = 0059h
; into the fourth word of the block, and preserves AX and DX.
; Slides: Chapter 8 Procedures, slide "Parameter Block".
ORG  100h         ; not in the slides: .COM program
LEA  BX, block
CALL calc         ; result = a x b + c
RET
calc PROC         ; In: BX = block address
PUSH AX
PUSH DX           ; MUL writes DX too
MOV  AX, [BX]     ; a
MUL  WORD PTR [BX+2] ; x b
ADD  AX, [BX+4]   ; + c
MOV  [BX+6], AX   ; result
POP  DX
POP  AX
RET
calc ENDP
block DW 12, 7, 5, ?

; REGISTERS: AX DX
; MEMORY: block 8
; Expected output:
; AX=0000h
; DX=0000h
; block: 0Ch 00h 07h 00h 05h 00h 59h 00h
