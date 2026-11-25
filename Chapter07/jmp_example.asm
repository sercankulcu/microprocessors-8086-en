; Unconditional jumps with JMP: the flow is 1 -> 2 -> 3 -> calc -> back -> stop, result AX = 7.
; Slides: Chapter 7 Flow Control, slide "JMP Example".
org    100h
mov    ax, 5          ; ax = 5
mov    bx, 2          ; bx = 2
jmp    calc           ; go to the calc label
back:  jmp stop       ; go to the stop label
calc:
add    ax, bx         ; ax = ax + bx
jmp    back           ; return to back
stop:
ret                   ; return to the operating system

; REGISTERS: AX BX

; Expected output:
; AX=0007h
; BX=0002h
