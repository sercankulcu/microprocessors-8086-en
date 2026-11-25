; Array: consecutive bytes; the quoted text expands to ASCII codes (a and b are the same bytes).
; Slides 4.2 Variables, slide "Arrays".
ORG 100h         ; not in the slides
RET              ; not in the slides
a DB 48h, 65h, 6Ch, 6Ch, 6Fh, 00h
b DB 'Hello', 0

; MEMORY: a 6
; MEMORY: b 6

; Expected output:
; a: 48h 65h 6Ch 6Ch 6Fh 00h
; b: 48h 65h 6Ch 6Ch 6Fh 00h
