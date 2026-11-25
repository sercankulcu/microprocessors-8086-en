; Changing a segment register temporarily: DS = B800h (video) between PUSH DS / POP DS;
; when SS changes, SP is set right after it.
; Slides 4.1 Memory Access, slide "Changing a Segment Register" (two pieces).
.model small            ; not in the slides: an .EXE for the new_stack segment
stk segment stack       ; not in the slides: the initial stack
dw 32 dup(0)            ; not in the slides
stk ends                ; not in the slides
new_stack segment       ; not in the slides: a second stack of 0400h bytes
dw 200h dup(0)          ; not in the slides
new_stack ends          ; not in the slides
code segment            ; not in the slides
assume cs:code          ; not in the slides
start:                  ; not in the slides
PUSH DS            ; save DS
MOV  AX, 0B800h
MOV  DS, AX        ; temporary
MOV  BYTE PTR [0], 'Z'
MOV  BL, DS:[0]    ; not in the slides: read back what was written
POP  DS            ; variables back

MOV  AX, new_stack
MOV  SS, AX        ; right after it
MOV  SP, 0400h     ; set SP
MOV  AX, 4C00h     ; not in the slides: back to DOS
INT  21h           ; not in the slides
code ends          ; not in the slides
end start          ; not in the slides

; REGISTERS: DS BL SP

; Expected output:
; Z
; DS=0700h
; BL=5Ah
; SP=0400h
