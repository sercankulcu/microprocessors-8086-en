; OUT 59h, AL and IN AL, 9Ah: each is one instruction fetch and one I/O bus cycle. An odd port
; address (59h) uses the high bank, an even port address (9Ah) the low bank.
; In the trace AL = 12h is written, port 9Ah returns 3Ch.
; Source: Chapter 10.1 8086 Pins, "From Instruction to Bus Cycles: OUT and IN"
; (the CS = 01A7h and address/byte columns of the slide are not here; the instruction bytes are
; the same: E6 59, E4 9A)
; PORT 154: 3Ch
; REGISTERS: AL

ORG 100h           ; not on the slide
mov al, 12h        ; not on the slide: ; CS = 01A7h, AL = 12h
out 59h, al
in  al, 9Ah
ret                ; not on the slide

; Expected output:
; OUT 89 <- 12h
; AL=3Ch
