; PUSHF / POPF: the flags of the first addition (CF = 1, ZF = 1) are saved and restored
; after the second addition.
; Slides: Chapter 8 The Stack, slide "PUSHF / POPF".
ORG   100h
MOV   AX, 0FFFFh
ADD   AX, 1      ; CF=1, ZF=1
PUSHF            ; save flags
MOV   BX, 5
ADD   BX, 3      ; CF=0, ZF=0
POPF             ; restore flags
RET

; REGISTERS: AX BX CF ZF
; Expected output:
; AX=0000h
; BX=0008h
; CF=1
; ZF=1
