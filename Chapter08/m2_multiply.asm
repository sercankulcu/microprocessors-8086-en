; Parameters in registers: m2 computes AL * BL. Two calls: 1 * 2 = 2, then 2 * 2 = 4.
; Slides: Chapter 8 Procedures, slides "Example: Multiplying with m2" and "Preserving Registers"
; (procedure header comment).
ORG    100h
MOV    AL, 1       ; 1st parameter
MOV    BL, 2       ; 2nd parameter
CALL   m2          ; 0104h: E8 04 00
CALL   m2          ; 0107h: E8 01 00
RET                ; 010Ah: to DOS
; m2: computes AL * BL
; In     : AL, BL (unsigned)
; Out    : AX = AL * BL
; Clobber: CF, OF
m2 PROC            ; 010Bh
MUL    BL          ; AX = AL * BL
RET                ; to caller
m2 ENDP
END

; REGISTERS: AX BL CF OF
; Expected output:
; AX=0004h
; BL=02h
; CF=0
; OF=0
