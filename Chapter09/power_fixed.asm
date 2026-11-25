; Fixed POWER: LOCAL labels (no Duplicate declaration on two uses), JCXZ so e = 0 -> 1 (no
; 65 536-round LOOP trap), BX/CX/DX preserved. 7^2 = 49 (0031h) and 7^0 = 1.
; Slides 9.1 "POWER: Pitfalls".
POWER MACRO b, e, r
      LOCAL p_loop, p_end
      PUSH BX
      PUSH CX
      PUSH DX
      MOV  AX, 1
      MOV  CX, e
      MOV  BX, b
      JCXZ p_end   ; e = 0 → 1
p_loop: MUL BX
      LOOP p_loop
p_end: MOV r, AX
      POP  DX
      POP  CX
      POP  BX
ENDM

ORG 100h                 ; not on the slide: two uses, data from the code-trace slide
      MOV  BX, 0AAAh     ; not on the slide: the caller's registers (as on the code-trace slide)
      MOV  CX, 0BBBh     ; not on the slide
      MOV  DX, 0CCCh     ; not on the slide
      POWER base, expn, res        ; not on the slide
      POWER base, zero, res0       ; not on the slide: expn = 0
      RET                ; not on the slide
base  dw 7               ; not on the slide
expn  dw 2               ; not on the slide
zero  dw 0               ; not on the slide
res   dw ?               ; not on the slide
res0  dw ?               ; not on the slide

; REGISTERS: AX BX CX DX
; MEMORY: res 2
; MEMORY: res0 2

; Expected output:
; AX=0001h
; BX=0AAAh
; CX=0BBBh
; DX=0CCCh
; res: 31h 00h
; res0: 01h 00h
