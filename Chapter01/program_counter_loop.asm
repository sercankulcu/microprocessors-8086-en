; Program counter (IP) and loop: LOOP adds 3 + 2 + 1, HLT stops.
; When LOOP jumps, the target address (0106h) is written into IP; the sequential flow is broken.
; Source: Chapter 1.1 Introduction, "Program Counter and Loop" (Code Trace: How Does IP Change?)
; In the slide the line starts are the instruction addresses 0100, 0103, ...; here they are shown in comments.

org 100h              ; not in the slides: a .COM program starts at 0100h

      mov  cx, 3     ; count = 3          (0100)
      mov  ax, 0     ; sum = 0            (0103)
again: add ax, cx    ;                    (0106)
      loop again     ; CX--, jump if CX≠0 (0108)
      hlt            ; halt               (010A)

; REGISTERS: AX CX

; Expected output:
; AX=0006h
; CX=0000h
