; A procedure: PRINT_A has a single copy in memory, each use is only a 3-byte CALL.
; Slides 9.1 "Procedure Properties".
ORG 100h                  ; not on the slide
      JMP start           ; not on the slide: so execution does not fall into the procedure

PRINT_A PROC
      PUSH AX
      MOV  AL, 'A'
      MOV  AH, 0Eh
      INT  10h
      POP  AX
      RET
PRINT_A ENDP

start:                    ; not on the slide
      CALL PRINT_A  ; 3 bytes
      CALL PRINT_A  ; 3 bytes
      RET                 ; not on the slide

; Expected output:
; AA
