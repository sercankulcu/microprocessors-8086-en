; Menu with a jump table: the key pressed ('1'..'3') is converted to a table index, CALL ops[BX]
; calls the matching procedure. The unsigned range check with JA also rejects '0' and '4'..'9'.
; Here '2' is pressed: BX = 2, diff is called.
; Slides: Chapter 8 Procedures, slide "Menu with a Jump Table".
; INPUT: "2"
ORG  100h         ; not in the slides: .COM program
MOV  AH, 1
INT  21h          ; AL = '1'..'3'
SUB  AL, '1'      ; 0..2
CMP  AL, 2
JA   invalid      ; range check
MOV  BL, AL
MOV  BH, 0
SHL  BX, 1        ; each address is 2 bytes
CALL ops[BX]
invalid: RET
ops DW sum, diff, prod
sum:  MOV DX, 1   ; not in the slides: DX shows which procedure was called
RET               ; not in the slides
diff: MOV DX, 2   ; not in the slides
RET               ; not in the slides
prod: MOV DX, 3   ; not in the slides
RET               ; not in the slides

; REGISTERS: AL BX DX
; Expected output:
; 2
; AL=01h
; BX=0002h
; DX=0002h
