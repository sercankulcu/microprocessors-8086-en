; Stepper motor (port 7): polls until bit 7 = 1 (ready), then writes the magnet byte from the
; table. 4 bytes make one round; after 20h rounds it moves to the next table (CW half -> CCW half
; -> CW full -> CCW full -> back to the start). Port 7 returns 00h (busy) first, then always
; 80h (ready). LIMIT shows the first round (110b, 100b, 011b, 010b) and the round counter
; becoming 1.
; Source: Chapter 10.2 Device Control, "Step Motor Program" (two slides) and "Step Motor Trace"
; PORT 7: 00h 80h
; LIMIT: 43
; REGISTERS: BX CX SI

option nokeyword:<wait>   ; not on the slide: in UASM WAIT is an instruction name, not a label
ORG 100h
steps_before_direction_change = 20h
jmp start
datcw     db 110b,100b,011b,010b
datccw    db 011b,001b,110b,010b
datcw_fs  db 001b,011b,110b,000b
datccw_fs db 100b,110b,011b,000b
start:
mov bx, offset datcw
mov si, 0
mov cx, 0   ; round counter
next_step:
wait: in al, 7
test al, 10000000b
jz wait
mov al, [bx][si]
out 7, al
inc si
cmp si, 4
jb next_step
mov si, 0
inc cx
cmp cx, steps_before_direction_change
jb  next_step
mov cx, 0
add bx, 4   ; next table
cmp bx, offset datccw_fs
jbe next_step
mov bx, offset datcw
jmp next_step

; Expected output:
; OUT 7 <- 06h
; OUT 7 <- 04h
; OUT 7 <- 03h
; OUT 7 <- 02h
; BX=0102h
; CX=0001h
; SI=0000h
