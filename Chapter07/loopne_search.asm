; Searching an array with LOOPNE: the value 3 is found at arr[2], the loop ends after 3 rounds (AL = 1, SI = 2).
; Slides: Chapter 7 Flow Control, slide "Searching with LOOPNE".
org 100h
mov cx, 5          ; element count
mov si, -1         ; the first inc makes it 0
scan:
inc si             ; next element
cmp arr[si], 3     ; is it the value 3?
loopne scan        ; go on if CX<>0 and ZF=0
jne notfound       ; ZF=0 -> not found
mov al, 1          ; found, position in SI
ret
notfound:
mov al, 0          ; not found
ret
arr db 7, 1, 3, 9, 4

; REGISTERS: AL SI CX ZF

; Expected output:
; AL=01h
; SI=0002h
; CX=0002h
; ZF=1
