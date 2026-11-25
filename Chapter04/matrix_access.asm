; A row-major byte matrix: mat[bx+si], BX is the row start (row x 4), SI the column.
; Slides 4.1 Memory Access, slide "Code Trace: Accessing a Matrix Element".
org 100h
mov bx, 2*4          ; row 2
mov si, 1            ; column 1
mov al, mat[bx+si]   ; mat[2][1]
mov si, 3            ; column 3
mov ah, mat[bx+si]   ; mat[2][3]
sub bx, 4            ; row 1
mov dl, mat[bx+si]   ; mat[1][3]
ret
mat db 11h,12h,13h,14h
    db 21h,22h,23h,24h
    db 31h,32h,33h,34h

; REGISTERS: AX DL BX SI

; Expected output:
; AX=3432h
; DL=24h
; BX=0004h
; SI=0003h
