; Printing a message with a procedure: print_me writes the zero-terminated string at SI using INT 10h teletype.
; Slides: Chapter 8 Procedures, slides "Hello World Message" (skeleton) and "print_me Trace".
ORG    100h
LEA    SI, msg       ; SI = address of msg
CALL   print_me
RET                  ; back to DOS
print_me PROC
next_char:
CMP  b.[SI], 0       ; zero?
JE   stop            ; yes: done
MOV  AL, [SI]        ; next ASCII char
MOV  AH, 0Eh         ; teletype function
INT  10h             ; print AL
ADD  SI, 1           ; next character
JMP  next_char       ; loop back
stop:
RET                  ; back to caller
print_me ENDP
msg DB 'Hello World!', 0
END

; REGISTERS: AL
; Expected output:
; Hello World!
; AL=21h
