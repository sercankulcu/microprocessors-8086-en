; The core of SCAN_NUM: digits are read left to right, result = result x 10 + digit; the result is in CX.
; Input 307 -> CX = 0133h. Slides 9.2 "SCAN_NUM Logic: Code Trace".
ORG  100h
XOR  CX, CX      ; result = 0
get_key: MOV AH, 01h
INT  21h         ; AL = key (echoed)
CMP  AL, 13      ; Enter?
JE   done
SUB  AL, '0'     ; ASCII → digit
CBW              ; AX = digit
XCHG AX, CX      ; AX=result, CX=digit
MOV  BX, 10
MUL  BX          ; AX = result × 10
ADD  CX, AX      ; CX = result×10 + digit
JMP  get_key
done: RET

; INPUT: "307\r"
; REGISTERS: CX AX BX ZF

; Expected output:
; 307
; CX=0133h
; AX=010Dh
; BX=000Ah
; ZF=1
