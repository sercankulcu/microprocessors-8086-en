; CALL and RET: CALL pushes the return address (0103h) on the stack, RET takes it back.
; Slides: Chapter 8 Procedures, slide "Example: CALL m1".
ORG    100h
CALL   m1         ; 0100h: E8 04 00
MOV    AX, 2      ; 0103h: B8 02 00
RET               ; 0106h: C3 -> DOS
m1 PROC
MOV    BX, 5      ; 0107h: BB 05 00
RET               ; 010Ah: C3 -> caller
m1 ENDP
END

; REGISTERS: AX BX
; Expected output:
; AX=0002h
; BX=0005h
