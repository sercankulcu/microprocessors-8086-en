; Copy 4 bytes with MOVSB + LOOP (= mov cx, 4 / rep movsb): each MOVSB does [ES:DI] <- [DS:SI],
; and since DF = 0 both SI and DI go up by one; at the end dst = 'ABCD'.
; In the trace src is at 010Eh, dst at 0112h; at the end SI = 0112h, DI = 0116h.
; Source: Chapter 11 Instruction Encoding and String Instructions, "Trace: MOVSB"
; REGISTERS: CX SI DI
; MEMORY: dst 4

org 100h
cld
lea si, src        ; DS:SI source
lea di, dst        ; ES:DI destination
mov cx, 4
copy_lp:
movsb              ; [DI]<-[SI], SI++, DI++
loop copy_lp       ; = rep movsb
ret
src db 'ABCD'
dst db 4 dup('.')

; Expected output:
; CX=0000h
; SI=0112h
; DI=0116h
; dst: 41h 42h 43h 44h
