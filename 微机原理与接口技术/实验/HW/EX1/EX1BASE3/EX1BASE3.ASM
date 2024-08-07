        ORG 0000H
        LJMP MAIN
        ORG 0003H
        LJMP INT
        ORG 0030H
MAIN:   CLR P1.0
        MOV TCON,#01H		;MOV TCON,#00H
        MOV IE,#81H
        SJMP $
INT:    PUSH PSW ; 保护现场
        CPL P1.0
        POP PSW ; 恢复现场
        RETI
        END
