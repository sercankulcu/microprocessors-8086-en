; The PUTC macro: writes a character, advances the cursor; AX is preserved. Every use is 8 bytes.
; Slides 9.1 "Writing a Character to the Screen" (the same body and the PUTC 'A' / PUTC 'B' use
; are also on the "Macro Properties" slide).
; prints a char, moves the cursor
PUTC  MACRO  char
      push  ax
      mov   al, char
      mov   ah, 0eh
      int   10h
      pop   ax
ENDM

ORG  100h
START:
      PUTC  'A'
      PUTC  'B'
      RET

; REGISTERS: AX

; Expected output:
; AB
; AX=0000h
