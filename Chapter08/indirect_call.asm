; Indirect CALL: the target address comes from memory (table[SI]) or from a register (BX).
; AX = 6 -> twice -> 12 -> add_one -> 13 = 000Dh.
; Slides: Chapter 8 Procedures, slide "Indirect CALL: Code Trace".
ORG  100h        ; not in the slides: .COM program
MOV  AX, 6
MOV  SI, 2       ; 2nd op (x 2)
CALL table[SI]   ; indirect, memory
MOV  BX, OFFSET add_one
CALL BX          ; indirect, register
RET
table DW add_one, twice
add_one: INC AX
RET
twice: SHL AX, 1
RET

; REGISTERS: AX BX SI
; MEMORY: table 4
; Expected output:
; AX=000Dh
; BX=0114h
; SI=0002h
; table: 14h 01h 16h 01h
