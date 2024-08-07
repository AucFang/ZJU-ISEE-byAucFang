        MODE EQU 082H   ;方式0，PA,PC输出
        CS0809 EQU 8000H
        PORTA EQU 9000H
        PORTB EQU 9001H
        PORTC EQU 9002H
        CADDR EQU 9003H ;控制字地址
        ORG 0000H
        MOV DPTR, #CADDR
        MOV A, #MODE
        MOVX @DPTR, A
        
        MOV DPTR, #CS0809
        MOV A, #0H
        MOVX @DPTR, A   ;启动A/D
        
        MOV A, #40H
        DJNZ ACC, $     ;延时>100ms
        
        MOVX A, @DPTR   ;读入结果
        MOV R7, #100
DLY:    MOV DPTR, #PORTA
        MOVX @DPTR, A
        DJNZ R7, DLY    ;延时
        LJMP 0
        SJMP $
        END 
