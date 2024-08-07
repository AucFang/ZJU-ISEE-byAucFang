        TICK EQU 10000          ;10000*100us=1s
        T100US EQU 156          ;100us时间常数(12MHz)
        C100US EQU 5H           ;100us计数单元
        LEDBUF BIT 00H          ;
        LED BIT P1.0
        ORG 0000H
        LJMP START
        ORG 000BH
        LJMP T0INT
        ORG 0100H
T0INT:  PUSH PSW
        MOV A, C100US+1
        JNZ GOON
        DEC C100US
GOON:   DEC C100US+1
        MOV A, C100US
        ORL A, C100US+1
        JNZ EXIT                 ;100us 记数器不为0, 返回
        MOV C100US, #HIGH(TICK)  ;#high(Tick)
        MOV C100US+1, #LOW(TICK) ;#low(Tick)
        CPL LEDBUF               ;100us 记数器为0, 重置记数器， 取反LED
EXIT:   POP PSW
        RETI
START:  MOV TMOD, #02H            ; 方式2, 定时器
        MOV TH0, #T100US
        MOV TL0, #T100US
        MOV IE, #10000010b         ; EA=1, IT0 = 1
        SETB TR0                   ; 开始定时
        CLR LEDBUF
        CLR P1.0
        MOV C100US, #HIGH(TICK)
        MOV C100US+1, #LOW(TICK)
LOOP:   MOV C, LEDBUF
        MOV P1.0, C
        SJMP LOOP
        END

