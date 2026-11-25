; Three more addressing modes: string (MOVSB), I/O (IN/OUT) and relative (JNZ, 75 FA = -6).
; Slides 4.1 Memory Access, slide "String, I/O and Relative Modes" (three separate pieces).
; So that the pieces run as one program, a pointer, a port number and a loop body were added.
; PORT 69: 7Fh
ORG 100h                ; not in the slides
LEA SI, src             ; not in the slides: DS:SI source
LEA DI, dst             ; not in the slides: ES:DI destination (ES = DS in a .COM)
CLD                     ; not in the slides: SI/DI go forward
MOVSB ; ES:[DI] <- DS:[SI]

IN  AL, 45h
MOV DX, 50h             ; not in the slides: the port for OUT DX
OUT DX, AX

MOV CX, 3               ; not in the slides: 3 rounds
again:                  ; not in the slides: 4-byte body (83 C3 02, 49)
ADD BX, 2               ; not in the slides
DEC CX                  ; not in the slides
JNZ again ; 75 FA = -6
RET                     ; not in the slides
src DB 'X'              ; not in the slides
dst DB '.'              ; not in the slides

; REGISTERS: AX BX SI DI
; MEMORY: dst 1

; Expected output:
; OUT 80 <- 007Fh
; AX=007Fh
; BX=0006h
; SI=0119h
; DI=011Ah
; dst: 58h
