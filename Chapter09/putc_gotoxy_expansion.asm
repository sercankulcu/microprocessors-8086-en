; What PUTC 'A' and GOTOXY 10, 5 expand to: PUTC is 5 instructions / 8 bytes, GOTOXY preserves
; AX, BX, DX and moves the cursor with INT 10h AH = 02h (DH = row, DL = column).
; Slides 9.2 "What Do PUTC and GOTOXY Expand To?" (two slides).
ORG  100h      ; not on the slide
PUSH AX        ; save AX
MOV  AL, 'A'   ; argument
MOV  AH, 0Eh   ; teletype
INT  10h
POP  AX        ; restore AX

PUSH AX
PUSH BX
PUSH DX
MOV  AH, 02h   ; set cursor position
MOV  DH, 5     ; row
MOV  DL, 10    ; column
MOV  BH, 0     ; page 0
INT  10h
POP  DX
POP  BX
POP  AX

MOV  AH, 0Eh   ; not on the slide: write 'B' to show the cursor's new place
MOV  AL, 'B'   ; not on the slide
INT  10h       ; not on the slide
RET            ; not on the slide

; Expected output:
; A
;
;
;
;
;           B
