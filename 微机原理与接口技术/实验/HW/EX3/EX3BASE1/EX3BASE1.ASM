        OUTBIT EQU 08002H       ;位控制口
        OUTSEG EQU 08004H       ;段控制口
        IN EQU 08001H           ;键盘输入口
        LEDBUF EQU 60H          ;显示缓冲
        NUM EQU 70H             ;显示的数据
        DELAYT EQU 75H          ;
        LJMP START
LEDMAP:      ;八段管显示码
        DB 3FH, 06H, 5BH, 4FH, 66H, 6DH, 7DH, 07H
        DB 7FH, 6FH, 77H, 7CH, 39H, 5EH, 79H, 71H
DELAY:          ;延时子程序
        MOV R7, #0H
DELAYLOOP:
        DJNZ R7, DELAYLOOP
        DJNZ R6, DELAYLOOP
        RET
DISPLAYLED:
        MOV R0, #LEDBUF
        MOV R1, #6H             ;共六个数码管
        MOV R2, #00100000B      ;从左边开始显示
LOOP:   MOV DPTR, #OUTBIT
        MOV A, #0H
        MOVX @DPTR, A           ;关闭所有八段管
        
        MOV A, @R0
        MOV DPTR, #OUTSEG
        MOVX @DPTR, A
        MOV DPTR, #OUTBIT
        MOV A, R2
        MOVX @DPTR, A           ;显示一位数码管
        
        MOV R6, #5H
        CALL DELAY
        
        MOV A, R2               ;显示下一位
        RR A
        MOV R2, A
        INC R0
        DJNZ R1, LOOP
        
        MOV DPTR, #OUTBIT
        MOV A, #0H
        MOVX @DPTR, A           ;关闭所有八段管     
        RET
        
START:  MOV SP, #40H
        MOV NUM, #0H
MLOOP:  INC NUM
        MOV A, NUM
        MOV B, A
        MOV R0, #LEDBUF
FILLBUF:MOV A, B
        ANL A, #0FH
        MOV DPTR, #LEDMAP
        MOVC A, @A+DPTR         ;数字转换成显示码
        MOV @R0, A
        INC R0
        INC B
        CJNE R0, #LEDBUF+6, FILLBUF
        MOV DELAYT, #30
DISPAGAIN:
        CALL DISPLAYLED         ;显示
        DJNZ DELAYT, DISPAGAIN

        LJMP MLOOP
        SJMP $
        END        
