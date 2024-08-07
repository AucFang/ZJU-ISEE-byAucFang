        ORG 0000H
LL:     MOV P2,#0FFH
        NOP
        MOV A, P2
        NOP
        MOV P1,A
        LJMP LL
        END
