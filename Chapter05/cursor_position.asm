; Positioning the cursor with INT 10h AH = 02h, then reading it with AH = 03h and moving it one to the right.
; Source: Chapter 5.2 slides, "Cursor: AH = 02h and 03h".
; REGISTERS: DX
org 100h        ; not in the slides: a .COM program
; move the cursor to the middle
mov ah, 02h
mov bh, 0
mov dx, 0C28h   ; row 12, column 40
int 10h

; move the cursor one to the right
mov ah, 03h
mov bh, 0
int 10h        ; DH, DL = position
inc dl
mov ah, 02h
int 10h
mov ah, 0Eh    ; not in the slides: write '*' to show where the cursor is
mov al, '*'    ; not in the slides
int 10h        ; not in the slides
ret            ; not in the slides: end the program

; Expected output:
;
;
;
;
;
;
;
;
;
;
;
;
;                                          *
; DX=0C29h
