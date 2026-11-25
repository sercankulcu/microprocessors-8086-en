; Swap in a single instruction with XCHG.
; Slides: Chapter 8 The Stack, slide "Swap Methods" (method 3).
ORG 100h          ; not in the slides: .COM program
MOV AX, 1212h     ; not in the slides: initial values
MOV BX, 3434h     ; not in the slides: initial values
XCHG AX, BX
RET               ; not in the slides: return to DOS

; REGISTERS: AX BX
; Expected output:
; AX=3434h
; BX=1212h
