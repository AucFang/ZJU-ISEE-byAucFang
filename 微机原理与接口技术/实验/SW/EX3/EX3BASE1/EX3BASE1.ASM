        RESULT EQU 30H
        ORG 0000H
        MOV A, #99H
        MOV B, #99H
        ADD A, B
        DA A
        MOV RESULT, A
        MOV A, #00H
        ADDC A, #00H
        MOV RESULT+1, A
        SJMP $
        END
        
        
        
        
        
        
