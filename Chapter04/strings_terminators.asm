; String formats: zero-terminated, '$'-terminated, with CR LF, length-prefixed, double-quoted.
; Slides 4.2 Variables, slide "Strings and Terminators".
ORG 100h                       ; not in the slides
RET                            ; not in the slides
s1 DB 'Welcome', 0             ; zero-terminated
s2 DB 'Welcome$'               ; '$'-terminated (INT 21h / AH = 09h)
s3 DB 13, 10, 'Line', 13, 10, '$' ; CR LF: carriage return + line feed
s4 DB 7, 'Welcome'             ; length-prefixed: first byte = 7
s5 DB "Ali's", 0               ; single quote inside double quotes

; MEMORY: s1 8
; MEMORY: s2 8
; MEMORY: s3 9
; MEMORY: s4 8
; MEMORY: s5 6

; Expected output:
; s1: 57h 65h 6Ch 63h 6Fh 6Dh 65h 00h
; s2: 57h 65h 6Ch 63h 6Fh 6Dh 65h 24h
; s3: 0Dh 0Ah 4Ch 69h 6Eh 65h 0Dh 0Ah 24h
; s4: 07h 57h 65h 6Ch 63h 6Fh 6Dh 65h
; s5: 41h 6Ch 69h 27h 73h 00h
