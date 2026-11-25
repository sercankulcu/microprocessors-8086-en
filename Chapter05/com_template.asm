; .COM program template: ORG 100h, single segment, exit with RET (or INT 20h).
; Source: Chapter 5.2 slides, "COM and EXE Templates".
org 100h
  mov dx, offset msg
  mov ah, 09h
  int 21h
  ret             ; or int 20h
msg db 'Welcome$'

; Expected output:
; Welcome
