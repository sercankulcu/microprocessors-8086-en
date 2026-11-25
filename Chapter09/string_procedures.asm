; String procedures: PRINT_STRING takes the string's address from DS:SI; PTHIS finds the
; string right after the CALL and moves the return address past the string.
; Slides 9.2 "String Procedures" (two slides).
include 'emu8086.inc'    ; not on the slide
ORG 100h                 ; not on the slide
LEA  SI, msg
CALL print_string
PUTC 13                  ; not on the slide: go to the next line
PUTC 10                  ; not on the slide
CALL pthis
DB 'Hello', 0
; execution continues here
RET                      ; not on the slide
msg DB 'Hello', 0        ; on the slide it sits right below CALL print_string; after RET so it never runs
DEFINE_PRINT_STRING      ; not on the slide
DEFINE_PTHIS             ; not on the slide

; Expected output:
; Hello
; Hello
