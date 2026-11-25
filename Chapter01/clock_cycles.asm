; How many clock cycles does a loop take? The 8086 cycle count is written next to each instruction.
; Total 4 + 4 + 4*3 + 3*17 + 5 + 2 = 78 cycles; at 5 MHz 78 x 200 ns = 15.6 us.
; Source: Chapter 1.1 Introduction, "Loop Time: Counting Clock Cycles"

org 100h
mov cx, 4        ; 4 cycles
mov ax, 0        ; 4 cycles
again: add ax, cx ; 3 cycles
loop again       ; 17 / 5 cycles
hlt              ; 2 cycles

; REGISTERS: AX CX

; Expected output:
; AX=000Ah
; CX=0000h
