        OUTBIT EQU 08002H
        OUTSEG EQU 08004H
        LEDBUF EQU 60H
        MODE EQU 082H   ;方式 0 PA PC 输出， PB 输入
        CADDR EQU 9003H
        CS0809 EQU 8000H
        ORG 0000H
        LJMP START
        ORG 0003H       ;INT0
        LJMP ADINT0
LEDMAP: ;八段管显示码
        DB 3FH, 06H, 5BH, 4FH, 66H, 6DH, 7DH, 07H
        DB 7FH, 6FH, 77H, 7CH, 39H, 5EH, 79H, 71H
START:  MOV SP, #5FH
        MOV R0, #50H
        MOV R2, #08H
        SETB IT0
        SETB EX0
        SETB EA
        CLR P3.3
        MOV DPTR, #CADDR
        MOV A, #MODE
        MOVX @DPTR, A
        MOV DPTR, #CS0809       ;AD通道0
        MOV A, #00H
        MOVX @DPTR, A   ;启动AD

MLOOP:  MOVX A, @DPTR   ;读入结果
        SJMP MLOOP

        ORG 0100H
ADINT0: MOVX A, @DPTR   ;读入结果
        MOV R7, A       ;保存结果
        CALL FILLBUF
DISPLAYLED:
        MOV R0, #LEDBUF
        MOV R2, #00000010B      ;从高位开始显示
        SJMP DLOOP
DLOOP:  MOV DPTR, #OUTBIT
        MOV A, #0H
        MOVX @DPTR, A           ;关闭所有八段管

        MOV A, @R0
        MOV DPTR, #OUTSEG
        MOVX @DPTR, A
        MOV DPTR, #OUTBIT
        MOV A, R2
        MOVX @DPTR, A           ;显示一位八段管
        MOV R5, #00H
DL1:    DJNZ R5, DL1
        INC R0
        MOV A, @R0
        MOV DPTR, #OUTSEG
        MOVX @DPTR, A
        MOV DPTR, #OUTBIT
        MOV A, R2
        RR A
        MOVX @DPTR, A           ;显示下一位八段管
        MOV R5, #00H
DL2:    DJNZ R5, DL2
        MOV DPTR, #OUTBIT
        MOV A, #0
        MOVX @DPTR, A           ;关闭所有八段管
        RETI
FILLBUF:ANL A, #0F0H
        SWAP A
        MOV DPTR, #LEDMAP
        MOVC A, @A+DPTR         ;数字第一位转换成显示码
        MOV R0, #LEDBUF
        MOV @R0, A
        MOV A, R7
        ANL A, #0FH
        MOV DPTR, #LEDMAP
        MOVC A, @A+DPTR         ;数字第二位转化成显示码
        INC R0
        MOV @R0, A
        MOV DPTR, #OUTBIT
        MOV A, #0
        MOVX @DPTR, A           ;关闭所有八段管
        RET
        SJMP $
        END


