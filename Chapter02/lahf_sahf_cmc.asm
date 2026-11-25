; LAHF, SAHF and CMC: after FFh + 1 the low byte of the flags is copied to AH (57h);
; CMC, CLC, STC change CF; SAHF writes AH = C1h to the flags: SF = ZF = CF = 1.
; Source: Chapter 2.2 8086 Registers, "LAHF, SAHF and CMC: Code Trace"

org 100h
mov al, 0FFh
add al, 1       ; CF ZF AF PF = 1
lahf            ; AH ← flags
cmc             ; flip CF
clc             ; CF = 0
stc             ; CF = 1
mov ah, 0C1h    ; 1100 0001b
sahf            ; flags ← AH
ret

; REGISTERS: AX SF ZF AF PF CF

; Expected output:
; AX=C100h
; SF=1
; ZF=1
; AF=0
; PF=0
; CF=1
