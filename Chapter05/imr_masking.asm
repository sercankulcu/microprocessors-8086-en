; Masking only IRQ1 (keyboard) through the 8259A IMR (port 21h) and then unmasking it:
; the read-modify-write pattern, OR to mask, AND to unmask.
; The example IMR value is B8h as in the slides; the second IN reads back the written BAh.
; Source: Chapter 5.1 slides, "Masking with the IMR: Code Trace".
; PORT 33: B8h BAh
; REGISTERS: AL
org 100h
in al, 21h           ; read the IMR
or al, 00000010b     ; mask IRQ1
out 21h, al
mov cx, 3            ; critical work
in al, 21h
and al, 11111101b    ; unmask IRQ1
out 21h, al
ret

; Expected output:
; OUT 33 <- BAh
; OUT 33 <- B8h
; AL=B8h
