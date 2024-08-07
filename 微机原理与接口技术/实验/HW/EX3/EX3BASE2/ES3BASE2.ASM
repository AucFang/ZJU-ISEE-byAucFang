        OUTBIT EQU 08002H       ;位控制口
        OUTSEG EQU 08004H       ;段控制口
        IN EQU 08001H           ;键盘输入口
        LEDBUF EQU 60H          ;显示缓冲
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
             
        RET

TESTKEY:MOV DPTR, #OUTBIT
        MOV A, #0
        MOVX @DPTR, A           ;输出线置为0，OUTBIT在控制LED的同时控制键盘的列选通
        MOV DPTR, #IN
        MOVX A, @DPTR
        CPL A                   ;按键按下为低电平，故需要取反
        ANL A, #0FH             ;高四位不用
        RET
KEYTABLE:        ; 键码定义
        DB 16H, 15H, 14H, 0FFH
        DB 13H, 12H, 11H, 10H
        DB 0DH, 0CH, 0BH, 0AH
        DB 0EH, 03H, 06H, 09H
        DB 0FH, 02H, 05H, 08H
        DB 00H, 01H, 04H, 07H
GETKEY: MOV DPTR, #OUTBIT
        MOV P2, DPH
        MOV R0, #LOW(IN)
        MOV R1, #00100000B
        MOV R2, #6H
KLOOP:  MOV A, R1               ;找出键所在列
        CPL A
        MOVX @DPTR, A
        CPL A
        RR A
        MOV R1, A               ;下一列
        MOVX A, @R0
        CPL A
        ANL A, #0FH
        JNZ GOON1               ;该列有输入
        DJNZ R2, KLOOP
        MOV R2, #0FFH           ;没有按键按下，返回0ffh
GOON1:  MOV R1, A               ;键值=列*4+行
        MOV A, R2
        DEC A
        RL A
        RL A
        MOV R2, A               ;R2 = (R2-1)*4,这里计算的是列数，5，4，3，2，1，0
        MOV A, R1
        MOV R1, #4
LOOPC:  RRC A                   ;移位找出所在行,A=00001000B就是第三行
        JC EXIT
        INC R2                  ;R2=R2+行值
        DJNZ R1, LOOPC
EXIT:   MOV A, R2               ;取出键码
        MOV DPTR, #KEYTABLE
        MOVC A, @A+DPTR
        MOV R2, A
WAITRELEASE:
        MOV DPTR, #OUTBIT       ;等键释放
        CLR A
        MOVX @DPTR, A
        MOV R6, #10
        CALL DELAY
        CALL TESTKEY
        JNZ WAITRELEASE
        MOV A, R2
        RET
        
START:  MOV SP, #40H
        MOV LEDBUF+0, #0FFH     ;显示8，8，8，8
        MOV LEDBUF+1, #0FFH     ;显示8，8，8，8
        MOV LEDBUF+2, #0FFH     ;显示8，8，8，8
        MOV LEDBUF+3, #0FFH     ;显示8，8，8，8
        MOV LEDBUF+4, #0     
        MOV LEDBUF+5, #0
MLOOP:  CALL DISPLAYLED
        CALL TESTKEY            ;有键入？
        JZ MLOOP                ;无键入，继续显示
        CALL GETKEY             ;读入键码
        ANL A, #0FH             ;显示键码
        MOV DPTR, #LEDMAP
        MOVC A, @A+DPTR
        MOV LEDBUF+5, A
        LJMP MLOOP      
        SJMP $
        END        
