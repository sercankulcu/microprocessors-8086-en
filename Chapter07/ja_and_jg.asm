; The same CMP, two different decisions: FBh is unsigned 251 (JA jumps), signed -5 (JG does not).
; Comparing 7Fh with 80h gives SF = OF = 1, so JG jumps (127 > -128).
; Result: CL = 0 (JA jumped), CH = 1 (JG did not jump), DL = 0 (the second JG jumped).
; Slides: Chapter 7 Flow Control, slide "JA and JG: Code Trace".
ORG  100h        ; not in the slides: .COM program
MOV  AL, 0FBh    ; 251 or -5
MOV  BL, 03h
CMP  AL, BL      ; FBh - 03h
JA   a1          ; unsigned: 251 > 3 ?
MOV  CL, 1       ; if JA failed
a1:  JG  g1      ; signed: -5 > 3 ?
MOV  CH, 1       ; JG not taken
g1:  MOV AL, 7Fh ; 127
CMP  AL, 80h     ; 127 - (-128)
JG   g2          ; SF = OF ?
MOV  DL, 1       ; if JG failed
g2:  RET

; REGISTERS: AL CL CH DL CF SF OF

; Expected output:
; AL=7Fh
; CL=00h
; CH=01h
; DL=00h
; CF=1
; SF=1
; OF=1
