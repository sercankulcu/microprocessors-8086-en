; CR and LF separately: LF alone moves down a line but the column stays; CR alone returns
; to the start of the line without erasing the text. The screen shows "ab" and below it "d c".
; Slides 9.2 "CR and LF Separately: Code Trace".
ORG  100h
MOV  AH, 0Eh     ; teletype
MOV  AL, 'a'
INT  10h
MOV  AL, 'b'
INT  10h
MOV  AL, 10      ; LF only
INT  10h
MOV  AL, 'c'
INT  10h
MOV  AL, 13      ; CR only
INT  10h
MOV  AL, 'd'
INT  10h
RET

; Expected output:
; ab
; d c
