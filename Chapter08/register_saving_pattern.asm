; A procedure saves the registers it uses with PUSH on entry and restores them with POP in REVERSE order on exit.
; Slides: Chapter 8 Procedures, slide "Preserving Registers".
ORG 100h          ; not in the slides: .COM program
MOV AX, 1111h     ; not in the slides: caller's values
MOV SI, 2222h     ; not in the slides
CALL show         ; not in the slides
RET               ; not in the slides: return to DOS
show PROC
    PUSH AX       ; save what
    PUSH SI       ; you use
    ; ... AX and SI are used
    MOV AX, 0     ; not in the slides: work that clobbers AX and SI
    MOV SI, 0     ; not in the slides
    POP  SI       ; in REVERSE
    POP  AX       ; order
    RET
show ENDP

; REGISTERS: AX SI
; Expected output:
; AX=1111h
; SI=2222h
