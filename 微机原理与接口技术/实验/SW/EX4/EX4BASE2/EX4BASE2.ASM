        ORG 0000H
HEXA:   MOV R2, #1BH
        MOV A, R2
        ANL A, #0FH
        ADD A, #09H
        MOVC A, @A+PC
        XCH A, R2
        ANL A, #0F0H
        SWAP A
        ADD A, #02H
        MOVC A, @A+PC
        MOV R3, A
        RET
TAB:    DB '0', '1', '2', '3', '4'
        DB '5', '6', '7', '8', '9'
        DB 'A', 'B', 'C', 'D', 'E', 'F'

        
