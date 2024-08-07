        RESULT EQU 30H
        ORG 0000H
        MOV A, #41H
        CLR C
        SUBB A, #37H
        MOV RESULT, A
        LJMP $
        END
