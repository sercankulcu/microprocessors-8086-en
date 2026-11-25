; Passing by value and by address: twice doubles the copy in AX, twice_m doubles the
; actual variable at [SI]. Result: AX = 10, a = 10.
; Slides: Chapter 8 Procedures, slide "By Value or By Address?".
ORG  100h         ; not in the slides: .COM program
MOV  AX, a        ; value: AX holds a copy of a
CALL twice        ; AX doubles, a stays the same
LEA  SI, a        ; address: SI = OFFSET a
CALL twice_m      ; [SI] doubles, a changes
RET               ; not in the slides: return to DOS
twice PROC        ; not in the slides: doubles AX
SHL  AX, 1        ; not in the slides
RET               ; not in the slides
twice ENDP        ; not in the slides
twice_m PROC      ; not in the slides: doubles the word at [SI]
SHL  WORD PTR [SI], 1 ; not in the slides
RET               ; not in the slides
twice_m ENDP      ; not in the slides
a DW 5            ; not in the slides: example variable

; The 10 in AX comes from the copy of a in the first call; the 10 in memory (a = 10) comes from the second call.
; REGISTERS: AX
; MEMORY: a 2
; Expected output:
; AX=000Ah
; a: 0Ah 00h
