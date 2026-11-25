; Two-dimensional arrays with nested DUP: 3 x 4 bytes = 12 bytes, 3 x 4 words = 24 bytes.
; Slides 4.2 Variables, slide "Two-Dimensional Arrays (Tables)".
ORG 100h               ; not in the slides
MOV AX, SIZEOF mat     ; not in the slides: the number of bytes in mat
MOV BX, SIZEOF tab     ; not in the slides: the number of bytes in tab
MOV CX, OFFSET tab - OFFSET mat   ; not in the slides: tab is 12 bytes after mat
RET                    ; not in the slides
mat DB 3 DUP(4 DUP(0)) ; 3 x 4
tab DW 3 DUP(4 DUP(0)) ; 24 bytes

; REGISTERS: AX BX CX

; Expected output:
; AX=000Ch
; BX=0018h
; CX=000Ch
