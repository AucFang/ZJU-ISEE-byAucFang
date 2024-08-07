        ORG 0000H
        MOV R0, #30H
        MOV R2, #10H
        MOV R3, #00H
        MOV 2CH, #00H
        MOV 2DH, #00H
        MOV 2EH, #00H
        MOV 2FH, #0FFH
LOOP:   CLR C
        MOV A, @R0
        MOV C, ACC.7
        JC  NEG
POS:    CLR C
        ADD A, 2CH
        MOV 2CH, A
        MOV A, 2DH
        ADDC A, #00H
        MOV 2DH, A
        LJMP LAST             
NEG:    ADD A, 2EH
        INC R3
        MOV 2EH, A
        MOV B.0, C
        CJNE R3, #01H, STEP
        SETB C
        MOV A, 2FH
        ADDC A, #0FFH
        MOV 2FH, A
        LJMP LAST
STEP:   MOV A, 2FH
        MOV C, B.0
        ADDC  A, #0FFH
        MOV 2FH, A
        LJMP LAST
LAST:   INC R0 
        DJNZ R2, LOOP
        SJMP $
        END     
        
        
        
                
