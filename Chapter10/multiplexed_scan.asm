; Multiplexed scan: the segment lines of four digits share port A (310h = 784), digit select is
; on port C (312h = 786). For each digit all digits are blanked first, the segment code is
; written, then only that digit is lit and delay_4ms (CX = 1000 LOOP iterations) waits;
; 1234 is scanned continuously.
; LIMIT covers one full scan (each digit is 11 + 1 + 1 + 1000 + 1 + 3 = 1017 instructions).
; Source: Chapter 10.2 Device Control, "Display Table and Scanning" (second part)
; LIMIT: 4000

ORG 100h          ; not on the slide
scan:
mov si, 0
next_dig:
mov dx, 312h      ; port C: digit select
mov al, 0
out dx, al        ; all digits blank first
mov al, digits[si]
mov bx, offset segtab   ; table from the first part
xlat
mov dx, 310h      ; port A: segments
out dx, al
mov al, select[si] ; 01h, 02h, 04h, 08h
mov dx, 312h
out dx, al        ; only this digit lit
call delay_4ms
inc si
cmp si, 4
jb  next_dig
jmp scan
delay_4ms:         ; ≈ 4 ms delay
mov cx, 1000
loop $
ret
digits db 1, 2, 3, 4
select db 01h, 02h, 04h, 08h
segtab db 3Fh,06h,5Bh,4Fh,66h   ; not on the slide: the table from the first part
       db 6Dh,7Dh,07h,7Fh,6Fh   ; not on the slide

; Expected output:
; OUT 786 <- 00h
; OUT 784 <- 06h
; OUT 786 <- 01h
; OUT 786 <- 00h
; OUT 784 <- 5Bh
; OUT 786 <- 02h
; OUT 786 <- 00h
; OUT 784 <- 4Fh
; OUT 786 <- 04h
; OUT 786 <- 00h
; OUT 784 <- 66h
; OUT 786 <- 08h
