; Defining a procedure with PROC / ENDP and calling it with CALL. The main program ends with RET;
; the procedure code is not executed in sequence, it is entered only with CALL.
; Slides: Chapter 8 Procedures, slide "Defining a Procedure" (general pattern: name PROC ... RET name ENDP).
; At the end the stack is balanced: the final RET takes DOS's 0000h, SP = 0000h.
ORG 100h
    CALL p1
    RET          ; main program ends
p1 PROC          ; after the RET:
    ; ...          ; never fallen into
    RET
p1 ENDP
END

; REGISTERS: SP
; Expected output:
; SP=0000h
