; Register protection: the stars procedure uses CX in its inner loop but protects the caller's counter
; with PUSH CX / POP CX. 2 rows x 3 '#': 6 characters on the screen.
; Slides: Chapter 8 Procedures, slide "Register Protection: Code Trace".
ORG  100h        ; not in the slides: .COM program
MOV  CX, 2       ; main loop: 2 rows
row: CALL stars
LOOP row
RET
stars PROC
PUSH CX          ; caller's counter
MOV  CX, 3       ; inner counter
MOV  AX, 0E23h   ; AH = 0Eh, AL = '#'
inner:  INT 10h
LOOP inner
POP  CX          ; counter back
RET
stars ENDP

; REGISTERS: AX CX
; Expected output:
; ######
; AX=0E23h
; CX=0000h
