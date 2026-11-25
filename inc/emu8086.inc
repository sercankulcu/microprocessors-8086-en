; Macros and procedures written from scratch for this repository, carrying the same names and
; interface as emu8086.inc. emu8086's own file ships with emu8086; the programs are assembled
; with that file in emu8086 and with this file here (with UASM).
;
; Macros    : PUTC char, GOTOXY col, row, PRINT 'text', PRINTN 'text', CURSOROFF, CURSORON
; Procedures: a DEFINE_xxx macro defines the procedure, which is used with CALL xxx
;   SCAN_NUM      reads a signed number from the keyboard into CX (Enter ends it)
;   PRINT_NUM     prints the signed number in AX (PRINT_NUM_UNS must be defined too)
;   PRINT_NUM_UNS prints the unsigned number in AX
;   PRINT_STRING  prints the 0-terminated string at DS:SI
;   PTHIS         prints the 0-terminated string that follows the CALL right away
;   GET_STRING    reads into the buffer at DS:DI up to Enter (DX = buffer size), appends a 0
;   CLEAR_SCREEN  clears the screen and moves the cursor to the top left
; The procedures preserve the registers they use (except the output register). As in emu8086,
; every DEFINE_ macro first jumps over the procedure, so the flow is not broken even if it is
; written in the middle of the program.

PUTC    MACRO   char
        PUSH    AX
        MOV     AL, char
        MOV     AH, 0Eh
        INT     10h
        POP     AX
ENDM

GOTOXY  MACRO   col, row
        PUSH    AX
        PUSH    BX
        PUSH    DX
        MOV     AH, 02h
        MOV     DH, row
        MOV     DL, col
        MOV     BH, 0
        INT     10h
        POP     DX
        POP     BX
        POP     AX
ENDM

PRINT   MACRO   sdat
        LOCAL   next_char, s_dcl, printed, skip_dcl
        PUSH    AX
        PUSH    SI
        JMP     skip_dcl
IFDIF <sdat>, <''>
s_dcl   DB      sdat, 0
ELSE
s_dcl   DB      0
ENDIF
skip_dcl:
        LEA     SI, s_dcl
next_char:
        MOV     AL, CS:[SI]
        CMP     AL, 0
        JZ      printed
        INC     SI
        MOV     AH, 0Eh
        INT     10h
        JMP     next_char
printed:
        POP     SI
        POP     AX
ENDM

PRINTN  MACRO   sdat
        LOCAL   next_char, s_dcl, printed, skip_dcl
        PUSH    AX
        PUSH    SI
        JMP     skip_dcl
IFDIF <sdat>, <''>
s_dcl   DB      sdat, 13, 10, 0
ELSE
s_dcl   DB      13, 10, 0
ENDIF
skip_dcl:
        LEA     SI, s_dcl
next_char:
        MOV     AL, CS:[SI]
        CMP     AL, 0
        JZ      printed
        INC     SI
        MOV     AH, 0Eh
        INT     10h
        JMP     next_char
printed:
        POP     SI
        POP     AX
ENDM

CURSOROFF MACRO
        PUSH    AX
        PUSH    CX
        MOV     AH, 1
        MOV     CH, 28h
        MOV     CL, 09h
        INT     10h
        POP     CX
        POP     AX
ENDM

CURSORON MACRO
        PUSH    AX
        PUSH    CX
        MOV     AH, 1
        MOV     CH, 08h
        MOV     CL, 09h
        INT     10h
        POP     CX
        POP     AX
ENDM

; ---------------------------------------------------------------- SCAN_NUM -> CX
; As in emu8086: every key is echoed first (Enter as CR); a non-digit key, a second '-' and a
; digit that would overflow 16 bits are erased after being echoed (backspace, space, backspace).
DEFINE_SCAN_NUM MACRO
        LOCAL   oku, bitti, eksi_mi, geri, sil, cik, cik_rakam, atla
        JMP     atla
SCAN_NUM PROC NEAR
        PUSH    AX
        PUSH    BX
        PUSH    DX
        PUSH    SI
        XOR     CX, CX
        XOR     SI, SI              ; SI = 1 if the number is negative
oku:
        MOV     AH, 0
        INT     16h
        MOV     AH, 0Eh             ; echo first
        INT     10h
        CMP     AL, 13
        JE      bitti
        CMP     AL, 8
        JE      geri
        CMP     AL, '-'
        JE      eksi_mi
        CMP     AL, '0'
        JB      sil
        CMP     AL, '9'
        JA      sil
        SUB     AL, '0'
        XOR     AH, AH
        MOV     BX, AX
        MOV     AX, CX
        MOV     DX, 10
        MUL     DX
        OR      DX, DX
        JNZ     sil                 ; exceeded 16 bits: reject the digit
        ADD     AX, BX
        JC      sil
        MOV     CX, AX
        JMP     oku
eksi_mi:
        OR      CX, CX
        JNZ     sil
        OR      SI, SI
        JNZ     sil
        MOV     SI, 1
        JMP     oku
sil:                                ; erase the echoed character from the screen
        MOV     AH, 0Eh
        MOV     AL, 8
        INT     10h
        MOV     AL, ' '
        INT     10h
        MOV     AL, 8
        INT     10h
        JMP     oku
geri:                               ; the cursor has already moved back one
        MOV     AH, 0Eh
        MOV     AL, ' '
        INT     10h
        MOV     AL, 8
        INT     10h
        OR      CX, CX
        JNZ     cik_rakam
        XOR     SI, SI              ; there was only a '-' or nothing at all
        JMP     oku
cik_rakam:
        MOV     AX, CX
        XOR     DX, DX
        MOV     BX, 10
        DIV     BX
        MOV     CX, AX
        JMP     oku
bitti:
        OR      SI, SI
        JZ      cik
        NEG     CX
cik:
        POP     SI
        POP     DX
        POP     BX
        POP     AX
        RET
SCAN_NUM ENDP
atla:
ENDM

; ---------------------------------------------------------------- PRINT_NUM (AX signed)
DEFINE_PRINT_NUM MACRO
        LOCAL   arti, atla
        JMP     atla
PRINT_NUM PROC NEAR
        PUSH    AX
        OR      AX, AX
        JNS     arti
        PUSH    AX
        MOV     AL, '-'
        MOV     AH, 0Eh
        INT     10h
        POP     AX
        NEG     AX
arti:
        CALL    PRINT_NUM_UNS
        POP     AX
        RET
PRINT_NUM ENDP
atla:
ENDM

; ---------------------------------------------------------------- PRINT_NUM_UNS (AX unsigned)
DEFINE_PRINT_NUM_UNS MACRO
        LOCAL   bol, yaz, atla
        JMP     atla
PRINT_NUM_UNS PROC NEAR
        PUSH    AX
        PUSH    BX
        PUSH    CX
        PUSH    DX
        MOV     BX, 10
        XOR     CX, CX
bol:
        XOR     DX, DX
        DIV     BX
        PUSH    DX
        INC     CX
        OR      AX, AX
        JNZ     bol
yaz:
        POP     AX
        ADD     AL, '0'
        MOV     AH, 0Eh
        INT     10h
        LOOP    yaz
        POP     DX
        POP     CX
        POP     BX
        POP     AX
        RET
PRINT_NUM_UNS ENDP
atla:
ENDM

; ---------------------------------------------------------------- PRINT_STRING (DS:SI)
DEFINE_PRINT_STRING MACRO
        LOCAL   sonraki, bitti, atla
        JMP     atla
PRINT_STRING PROC NEAR
        PUSH    AX
        PUSH    SI
sonraki:
        MOV     AL, [SI]
        CMP     AL, 0
        JZ      bitti
        INC     SI
        MOV     AH, 0Eh
        INT     10h
        JMP     sonraki
bitti:
        POP     SI
        POP     AX
        RET
PRINT_STRING ENDP
atla:
ENDM

; ---------------------------------------------------------------- PTHIS (string after the CALL)
DEFINE_PTHIS MACRO
        LOCAL   sonraki, bitti, atla
        JMP     atla
PTHIS   PROC NEAR
        POP     SI                  ; return address = start of the string
        PUSH    AX
sonraki:
        MOV     AL, CS:[SI]
        INC     SI
        CMP     AL, 0
        JZ      bitti
        MOV     AH, 0Eh
        INT     10h
        JMP     sonraki
bitti:
        POP     AX
        PUSH    SI                  ; return to the instruction after the string
        RET
PTHIS   ENDP
atla:
ENDM

; ---------------------------------------------------------------- GET_STRING (DS:DI, DX size)
DEFINE_GET_STRING MACRO
        LOCAL   oku, bitti, geri, ekle, atla
        JMP     atla
GET_STRING PROC NEAR
        PUSH    AX
        PUSH    CX
        PUSH    DI
        PUSH    DX
        XOR     CX, CX              ; number of characters read
        CMP     DX, 1
        JBE     bitti
        DEC     DX                  ; leave room for the 0
oku:
        MOV     AH, 0
        INT     16h
        CMP     AL, 13
        JE      bitti
        CMP     AL, 8
        JE      geri
        CMP     CX, DX
        JAE     oku
ekle:
        MOV     [DI], AL
        INC     DI
        INC     CX
        MOV     AH, 0Eh
        INT     10h
        JMP     oku
geri:
        JCXZ    oku
        DEC     DI
        DEC     CX
        MOV     AH, 0Eh
        MOV     AL, 8
        INT     10h
        MOV     AL, ' '
        INT     10h
        MOV     AL, 8
        INT     10h
        JMP     oku
bitti:
        MOV     BYTE PTR [DI], 0
        POP     DX
        POP     DI
        POP     CX
        POP     AX
        RET
GET_STRING ENDP
atla:
ENDM

; ---------------------------------------------------------------- CLEAR_SCREEN
DEFINE_CLEAR_SCREEN MACRO
        LOCAL   atla
        JMP     atla
CLEAR_SCREEN PROC NEAR
        PUSH    AX
        PUSH    BX
        PUSH    CX
        PUSH    DX
        MOV     AX, 0600h
        MOV     BH, 07h
        MOV     CX, 0
        MOV     DX, 184Fh
        INT     10h
        MOV     AH, 02h
        MOV     BH, 0
        MOV     DX, 0
        INT     10h
        POP     DX
        POP     CX
        POP     BX
        POP     AX
        RET
CLEAR_SCREEN ENDP
atla:
ENDM
