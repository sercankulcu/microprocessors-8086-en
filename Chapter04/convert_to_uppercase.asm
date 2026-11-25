; Converting a zero-terminated string to upper case in place: 20h is subtracted only from 'a'..'z'.
; Slides 4.2 Variables, slide "Code Trace: Converting a String to Upper Case".
; As in the trace, s = 0119h; at the terminator SI = 011Dh.
ORG 100h
LEA SI, s
again:
MOV AL, [SI]
CMP AL, 0          ; terminator?
JE done
CMP AL, 'a'
JB next
CMP AL, 'z'
JA next
SUB AL, 20h        ; 'a' - 'A'
MOV [SI], AL
next:
INC SI
JMP again
done:
RET
s DB 'Ab1c', 0

; REGISTERS: AL SI ZF
; MEMORY: s 5

; Expected output:
; AL=00h
; SI=011Dh
; ZF=1
; s: 41h 42h 31h 43h 00h
