; Traffic lights (port 4): first all directions red (all_red = 0249h), then the state table
; situation -> s1 -> s2 -> s3 -> s4 -> situation ... is written to port 4 at 5-second
; intervals (INT 15h/86h). Endless loop: LIMIT covers the first round and the first OUT after
; the restart.
; In the trace the table is at 0124h, sit_end = 012Eh.
; Source: Chapter 10.2 Device Control, "Traffic Program", "State Table", "Waiting with INT 15h"
; LIMIT: 52
; REGISTERS: AX SI

#start=Traffic_Lights.exe#
ORG 100h         ; not on the slide
mov ax, all_red
out 4, ax
mov si, offset situation
next:
mov ax, [si]
out 4, ax
mov cx, 4Ch      ; wait 5 s
mov dx, 4B40h
mov ah, 86h
int 15h
add si, 2        ; next state
cmp si, sit_end
jb  next
mov si, offset situation
jmp next

;                 FEDC_BA98_7654_3210
situation     dw  0000_0011_0000_1100b
s1            dw  0000_0110_1001_1010b
s2            dw  0000_1000_0110_0001b
s3            dw  0000_1000_0110_0001b
s4            dw  0000_0100_1101_0011b
sit_end = $
all_red       equ 0000_0010_0100_1001b

; Expected output:
; OUT 4 <- 0249h
; OUT 4 <- 030Ch
; OUT 4 <- 069Ah
; OUT 4 <- 0861h
; OUT 4 <- 0861h
; OUT 4 <- 04D3h
; OUT 4 <- 030Ch
; AX=030Ch
; SI=0124h
