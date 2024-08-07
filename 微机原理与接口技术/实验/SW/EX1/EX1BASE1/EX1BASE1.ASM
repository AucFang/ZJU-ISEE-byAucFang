        ORG 0000H
        START EQU 8000H
MAIN:   MOV DPTR, #START        ;起始地址
        MOV R0, #0              ;设置256字节计数
        MOV A, #1H
LOOP:   MOVX @DPTR, A
        INC DPTR
        DJNZ R0, LOOP
        NOP
        SJMP $
        END
