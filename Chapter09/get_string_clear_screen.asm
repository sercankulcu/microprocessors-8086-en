; GET_STRING reads a 0-terminated string from the keyboard into the buffer at DS:DI
; (DX = size); CLEAR_SCREEN clears the screen and puts the cursor at (0, 0); the string is
; written with PRINT_STRING. Slides 9.2 "GET_STRING and CLEAR_SCREEN".
include 'emu8086.inc'    ; not on the slide
ORG 100h                 ; not on the slide
LEA  DI, buf         ; buffer
MOV  DX, 20          ; size
CALL get_string
CALL clear_screen
LEA  SI, buf
CALL print_string
RET
buf DB 20 DUP(0)
DEFINE_GET_STRING        ; not on the slide
DEFINE_CLEAR_SCREEN      ; not on the slide
DEFINE_PRINT_STRING      ; not on the slide

; INPUT: "Ece\r"
; MEMORY: buf 4

; Expected output:
; Ece
; buf: 45h 63h 65h 00h
