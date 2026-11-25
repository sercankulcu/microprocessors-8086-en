; Pointer variable: p DW arr holds an address in memory; MOV BX, p gives its contents, LEA SI, p its address.
; far_p DD arr keeps the offset and the segment together.
; Slides 4.2 Variables, slide "Pointer Variables".
ORG 100h
MOV BX, p          ; 010Bh
LEA SI, p          ; 010Fh
MOV DI, OFFSET arr
RET
arr   DB 'KAYA'    ; 010Bh
p     DW arr       ; 010Fh, holds 010Bh
; far_p DD arr     ; offset + segment
far_p DW arr, 0    ; not in the slides: the segment part of 'far_p DD arr' needs a relocation
                   ; and does not assemble in the .COM binary output (UASM -bin). Here the segment part is 0.

; REGISTERS: BX SI DI
; MEMORY: p 2

; Expected output:
; BX=010Bh
; SI=010Fh
; DI=010Bh
; p: 0Bh 01h
