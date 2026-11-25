; A simple I/O test device: port 110 is a byte, port 112 a word. Inputs FFh and 7FFFh:
; INC AL -> 00h (ZF = 1, CF unchanged), ADD AX, 1 -> 8000h (OF = 1, SF = 1, CF = 0).
; Source: Chapter 10.2 Device Control, "Test Device: Code Trace"
; (the same code as the "Test Device" slide, with the A7h -> A8h and 1234h -> 1235h example)
; PORT 110: FFh
; PORT 112: 7FFFh
; REGISTERS: AX ZF SF OF CF

org 100h
in   al, 110     ; read byte
inc  al
out  110, al     ; write byte
in   ax, 112     ; read word
add  ax, 1
out  112, ax     ; write word
ret

; Expected output:
; OUT 110 <- 00h
; OUT 112 <- 8000h
; AX=8000h
; ZF=0
; SF=1
; OF=1
; CF=0
