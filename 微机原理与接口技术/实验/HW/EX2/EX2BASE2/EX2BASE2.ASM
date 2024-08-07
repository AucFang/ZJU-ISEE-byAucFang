        LJMP MAIN
        ORG 000BH
        LJMP TIMER0
        ORG 0030H
MAIN:   CLR P1.0
        MOV TMOD,#0AH
        MOV TL0,#50H
        MOV TH0,#50H
        SETB TR0
        MOV IE, #082H;¿ªÖÐ¶Ï
        SJMP $
TIMER0: CPL P1.0
        RETI
        END
