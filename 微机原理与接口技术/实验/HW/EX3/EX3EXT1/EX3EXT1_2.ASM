        OUTBIT EQU 08002H       ;位控制口
        OUTSEG EQU 08004H       ;段控制口
        LEDBUF EQU 60H          ;显示缓冲
        NUM EQU 70H             ;显示的数据
        ORG 0000H
        LJMP START
        ORG 000BH
        LJMP T0INT
        ORG 0100H
LEDMAP:      ;八段管显示码A~F各段
        DB  01H, 02H, 04H, 08H, 10H, 20H

START: MOV R7, #00H             ;偏移量
       MOV R6, #0AH             ;定时次数
       MOV TL0, #0F0H
       MOV TH0, #0D8H           ;10MS定时初值=55536=D8F0
       MOV TMOD, #01H            ;定时器0选择工作方式1，定时模式
       SETB EA
       SETB ET0
       SETB TR0
       MOV R2, #01H
       MOV DPTR, #OUTBIT
       MOV A, R2
       MOVX @DPTR, A             ;OUTBIT选择最后一个数码管
MLOOP: MOV DPTR, #LEDMAP
       MOV A, R7
       MOVC A, @A+DPTR
       MOV DPTR, #OUTSEG
       MOVX @DPTR, A
       LJMP MLOOP
       SJMP $
T0INT: DJNZ R6, RTN
       INC R7
       MOV R6, #0AH
       CJNE R7, #5H, RTN
       MOV R7, #0H
RTN:   MOV TL0, #0F0H
       MOV TH0, #0D8H
       RETI
       END
