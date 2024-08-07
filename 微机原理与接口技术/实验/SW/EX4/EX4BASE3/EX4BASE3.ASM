        ORG 0000H
START:  MOV DPTR, #TAB
        MOV R7, #02H
        MOV A, R7
        ADD A, R7
        JMP @A+DPTR

        ORG 0100H
TAB:    AJMP PROG0
        AJMP PROG1
        AJMP PROG2
        AJMP PROG3
        SJMP $
PROG0:  MOV A, #00H
        SJMP RE
PROG1:  MOV A, #01H
        SJMP RE
PROG2:  MOV A, #02H
        SJMP RE
PROG3:  MOV A, #03H
        SJMP RE
RE:     NOP
        SJMP $
        END
