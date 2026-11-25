; Address wraparound: FFFF:0510 = FFFF0h + 0510h = 100500h; the 8086's 20 address lines drop
; the 21st bit and access 00500h. The 77h written to 0000:0500 is read back from FFFF:0510.
; Source: Chapter 2.1 8086 Architecture, "Address Wraparound: Code Trace"

org 100h
mov ax, 0
mov ds, ax
mov byte ptr [0500h], 77h
mov ax, 0FFFFh
mov ds, ax
mov bl, [0510h]    ; FFFF:0510
ret

; REGISTERS: BL

; Expected output (real 8086):
; BL=77h
