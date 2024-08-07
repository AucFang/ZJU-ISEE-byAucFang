        ORG 0000H
        LJMP MAIN
        ORG 000BH
        LJMP T0INT
        ORG 0050H
MAIN:   MOV A, #055H
        MOV R0, #14H
        MOV TH0, #3CH
        MOV TL0, #0B0H  ;65536-50000/1=15536
        MOV TMOD, #01H
        MOV IE, #082H
OUTPUT: MOV P1, A       ;RL A
        SETB TR0
        SJMP $
T0INT:  PUSH PSW
        DJNZ R0, RETURN
        RL A
        MOV P1, A
        MOV R0, #14H
RETURN: MOV TH0, #3CH
        MOV TL0, #0B0H
        POP PSW
        RETI
        END
