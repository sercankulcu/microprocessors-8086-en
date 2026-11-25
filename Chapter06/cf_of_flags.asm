; CF and OF: the same addition can overflow separately in the unsigned and the signed
; reading; INC does not touch CF, CMC complements CF. The final flags are those of the last
; line of the trace in the slides.
; Source: Chapter 6 slides, "CF and OF: Code Trace".
; REGISTERS: AL CF ZF SF OF AF PF
org 100h         ; not in the slides: .COM program
MOV  AL, 9Ch     ; 156 or -100
ADD  AL, 70h     ; + 112
MOV  AL, 50h     ; 80
ADD  AL, 50h     ; + 80
ADD  AL, AL      ; A0h + A0h
MOV  AL, 0FFh
INC  AL          ; does not touch CF
CMC              ; complement CF
RET

; Expected output:
; AL=00h
; CF=0
; ZF=1
; SF=0
; OF=0
; AF=1
; PF=1
