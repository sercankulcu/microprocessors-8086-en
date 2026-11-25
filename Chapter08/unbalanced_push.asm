; RUN: compile only
; FAULTY CODE: the POP for PUSH AX was forgotten. RET takes the 1234h at the top of the stack as the
; return address, and the CPU executes random bytes at 0700:1234h. That is why it is only compiled.
; The fix: POP AX before RET.
; Slides: Chapter 8 The Stack, slide "Error: Unbalanced PUSH".
ORG   100h
MOV   AX, 1234h
PUSH  AX         ; POP forgotten!
RET              ; IP <- ?
