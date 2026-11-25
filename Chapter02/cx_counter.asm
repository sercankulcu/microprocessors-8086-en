; CX counter: LOOP first decrements CX by 1, jumps if CX ≠ 0; the body runs 5 times.
; Source: Chapter 2.2 8086 Registers, "CX — Counter"

org 100h        ; not in the slides: .COM program
MOV CX, 0005h   ; 5 passes
NEXT:
  ; ... body ...
  LOOP NEXT      ; CX--, jump if CX≠0
RET             ; not in the slides: return to DOS

; REGISTERS: CX

; Expected output:
; CX=0000h
