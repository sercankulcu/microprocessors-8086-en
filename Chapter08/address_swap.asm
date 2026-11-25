; Pass by address: the swap procedure exchanges the contents of the addresses in SI and DI, preserves AX.
; Slides: Chapter 8 Procedures, slide "Swap by Address: Code Trace".
; As in the trace, a = 0113h, b = 0115h.
ORG  100h
LEA  SI, a
LEA  DI, b
CALL swap
RET
swap PROC        ; In: SI, DI (addresses)
PUSH AX
MOV  AX, [SI]
XCHG AX, [DI]
MOV  [SI], AX
POP  AX
RET
swap ENDP
a    DW 1234h
b    DW 00FFh

; REGISTERS: AX SI DI
; MEMORY: a 2
; MEMORY: b 2
; Expected output:
; AX=0000h
; SI=0113h
; DI=0115h
; a: FFh 00h
; b: 34h 12h
