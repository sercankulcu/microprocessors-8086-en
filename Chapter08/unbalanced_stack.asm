; RUN: compile only
; FAULTY CODE: the procedure does PUSH AX and forgets POP AX. RET takes the 1234h at the top of the stack
; as the return address (IP = 1234h) and the program crashes. That is why it is only compiled.
; The fix: POP AX before the procedure's RET.
; Slides: Chapter 8 Procedures, slide "Unbalanced Stack".
ORG 100h
MOV  AX, 1234h     ; 0100h: B8 34 12
CALL bad           ; 0103h: return = 0106h
RET                ; 0106h
bad PROC
PUSH AX            ; AX saved...
; ... work ...
RET                ; forgot POP AX!
bad ENDP
