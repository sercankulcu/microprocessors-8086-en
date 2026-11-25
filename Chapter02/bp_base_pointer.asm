; BP base pointer: at procedure entry PUSH BP + MOV BP, SP; the parameter on the stack
; is read from [BP+4] ([BP] is the old BP, [BP+2] the return address). RET 2 removes the parameter from the stack.
; Source: Chapter 2.2 8086 Registers, "BP — Base Pointer"

org 100h               ; not in the slides: .COM program
  MOV  BX, 0025h       ; not in the slides: parameter
  PUSH BX              ; not in the slides: push the parameter
  CALL ADDP            ; not in the slides: call the procedure
  MOV  DX, SP          ; not in the slides: SP after RET 2 (FFFEh: parameter removed)
  RET                  ; not in the slides: return to DOS

ADDP PROC
  PUSH BP
  MOV  BP, SP     ; frame base
  MOV  AX, [BP+4] ; 1st param
  POP  BP
  RET  2
ADDP ENDP

; REGISTERS: AX DX

; Expected output:
; AX=0025h
; DX=FFFEh
