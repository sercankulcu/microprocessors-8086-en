; .COM program template: code starts at 0100h (preceded by the 256-byte PSP), variables
; sit after RET and are not executed as instructions. num is at 010Bh.
; Source: Chapter 3.2 Assembly, ".COM Program Template" and ".COM Program: Code Trace"

ORG 100h          ; .COM: code starts at 0100h

MOV AX, 5         ; AX = 5
MOV BX, 3         ; BX = 3
ADD AX, BX        ; AX = AX + BX = 8
MOV CL, AL        ; CL = 08h

RET               ; back to DOS

num DB 0          ; variables go after RET

; REGISTERS: AX BX CL
; MEMORY: num 1

; Expected output:
; AX=0008h
; BX=0003h
; CL=08h
; num: 00h
