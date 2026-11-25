; Caller saves: read_num returns its result in CX, so the caller saves the loop counter.
; Three numbers are read (10, 20, 30), total = 60 = 003Ch. Because SCAN_NUM echoes Enter as CR,
; each number is written at the start of the same line; only the last number (30) remains on screen.
; Slides: Chapter 8 Procedures, slide "Caller or Callee: Who Saves?".
; INPUT: "10\r20\r30\r"
include 'emu8086.inc'  ; not in the slides: for SCAN_NUM
ORG 100h               ; not in the slides: .COM program
MOV  CX, 3             ; not in the slides: three numbers to read
again: PUSH CX         ; caller: counter
       CALL read_num   ; result in CX
       ADD  total, CX
       POP  CX         ; counter back
       LOOP again
RET                    ; not in the slides: return to DOS
read_num PROC          ; not in the slides: reads a number from the keyboard, returns it in CX
CALL SCAN_NUM          ; not in the slides
RET                    ; not in the slides
read_num ENDP          ; not in the slides
total DW 0             ; not in the slides
DEFINE_SCAN_NUM        ; not in the slides

; REGISTERS: CX
; MEMORY: total 2
; Expected output:
; 30
; CX=0000h
; total: 3Ch 00h
