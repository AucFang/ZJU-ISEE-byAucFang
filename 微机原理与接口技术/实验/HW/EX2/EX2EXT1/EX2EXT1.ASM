        ORG 0000H
        LJMP MAIN
        ORG 001BH
        LJMP INT
        ORG 0100H
MAIN:   MOV TMOD, #10H
        MOV TH1, #3CH           ;定时时间：50000us=50ms=0.05S
        MOV TL1, #0B0H
        MOV R7, #0
        MOV P1, #1
        SETB EA
        SETB ET1
        SETB TR1
        SJMP $
        ORG 0200H
INT:    CJNE R7, #0, NEXT0
        MOV P1, #1              ;P1.0 ON
NEXT0:  INC R7
        MOV TH1, #3CH
        MOV TL1, #0B0H
        CJNE R7, #5, NEXT1
        MOV P1, #2              ;0.25S P1.1 ON
        RETI
NEXT1:  CJNE R7, #15, NEXT2
        MOV P1, #4              ;0.75S P1.2 ON
        RETI
NEXT2:  CJNE R7, #30, NEXT3
        MOV P1, #8              ;1.5S P1.3 ON
        RETI
NEXT3:  CJNE R7, #50, NEXT4     
        MOV P1, #16             ;2.5S P1.4 ON
        RETI
NEXT4:  CJNE R7, #55, NEXT5
        MOV P1, #32             ;2.75S P1.5 ON
        RETI
NEXT5:  CJNE R7, #65, NEXT6
        MOV P1, #64             ;3.25S P1.6 ON
        RETI
NEXT6:  CJNE R7, #80, NEXT7     
        MOV P1, #128            ;4S P1.7 ON
NEXT7:  CJNE R7,#100,ENDINT
        MOV R7,#0               ;5S ALL OFF
ENDINT: RETI
