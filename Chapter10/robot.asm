; Robot (port 9 command, 10 data, 11 status): before every command it waits until the busy bit
; (bit 1) is zero; after the examine (4) command it waits until the new-data bit (bit 0) is one.
; If there is a wall ahead (FFh) turn right (3), if there is a lamp that is off (8) switch it
; on (5), otherwise go forward (1).
; Here port 11 always returns 01h (ready, data present), port 10 returns in turn 0 (empty),
; 8 (lamp off), FFh (wall), 0. Endless loop.
; Source: Chapter 10.2 Device Control, "Robot Program" and "Robot: Waiting for Data"
; PORT 11: 01h
; PORT 10: 0 8 0FFh 0
; LIMIT: 78

#start=robot.exe#
ORG 100h       ; not on the slide
main_loop: CALL wait_ready
       MOV  AL, 4       ; examine
       OUT  9, AL
       CALL wait_data
       IN   AL, 10
       CMP  AL, 0FFh    ; wall?
       JE   turn
       CMP  AL, 8       ; lamp off?
       JNE  advance
       CALL wait_ready
       MOV  AL, 5       ; lamp on
       OUT  9, AL
       JMP  main_loop
turn:  MOV  AL, 3       ; turn right
       JMP  send
advance: MOV AL, 1      ; forward
send:  PUSH AX          ; keep the command
       CALL wait_ready
       POP  AX
       OUT  9, AL
       JMP  main_loop

wait_ready PROC
b1:    IN   AL, 11
       TEST AL, 010b    ; busy?
       JNZ  b1
       RET
wait_ready ENDP

wait_data PROC
v1:    IN   AL, 11
       TEST AL, 001b    ; new data?
       JZ   v1
       RET
wait_data ENDP

; Expected output:
; OUT 9 <- 04h
; OUT 9 <- 01h
; OUT 9 <- 04h
; OUT 9 <- 05h
; OUT 9 <- 04h
; OUT 9 <- 03h
