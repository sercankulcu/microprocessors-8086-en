; Aligned (even address) and unaligned (odd address) word access. The word written to 20100h
; takes one bus cycle, the word written to 20101h takes two; the result in memory is 34h CDh ABh.
; Byte read gives AL = 34h (AX = AB34h), unaligned word read gives BX = ABCDh.
; Source: Chapter 10.1 8086 Pins, "Code Trace: Aligned and Unaligned Access"
; REGISTERS: AX BX DS
; MEMORY: address 3

ORG 100h           ; not on the slide
mov ax, 2000h
mov ds, ax
mov ax, 1234h
mov [0100h], ax    ; even address
mov ax, 0ABCDh
mov [0101h], ax    ; odd address
mov al, [0100h]    ; byte
mov bx, [0101h]    ; odd address
ret                ; not on the slide
address equ 0100h  ; not on the slide: DS:0100h for the MEMORY directive

; Expected output:
; AX=AB34h
; BX=ABCDh
; DS=2000h
; address: 34h CDh ABh
