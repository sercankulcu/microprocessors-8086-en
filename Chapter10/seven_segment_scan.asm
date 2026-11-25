; Showing 2026 with multiplexed scanning: for each digit port C (312h = 786) <- 00h, port A
; (310h = 784) <- segment code, port C <- digit select. The codes are 5Bh 3Fh 5Bh 7Dh.
; Source: Chapter 10.2 Device Control, "7-Segment Scanning: Code Trace"
; REGISTERS: SI AL

org 100h
mov bx, offset segtab
mov si, 0
next_dig:
mov dx, 312h  ; port C (digit)
mov al, 0
out dx, al    ; all blank
mov al, digits[si]
xlat          ; segment code
mov dx, 310h  ; port A (segments)
out dx, al
mov al, select[si]
mov dx, 312h
out dx, al    ; one digit lit
inc si
cmp si, 4
jb  next_dig
ret
segtab db 3Fh,06h,5Bh,4Fh,66h
       db 6Dh,7Dh,07h,7Fh,6Fh
digits db 2, 0, 2, 6
select db 01h, 02h, 04h, 08h

; Expected output:
; OUT 786 <- 00h
; OUT 784 <- 5Bh
; OUT 786 <- 01h
; OUT 786 <- 00h
; OUT 784 <- 3Fh
; OUT 786 <- 02h
; OUT 786 <- 00h
; OUT 784 <- 5Bh
; OUT 786 <- 04h
; OUT 786 <- 00h
; OUT 784 <- 7Dh
; OUT 786 <- 08h
; SI=0004h
; AL=08h
