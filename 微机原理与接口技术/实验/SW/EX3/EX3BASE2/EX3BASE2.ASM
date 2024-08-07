        ORG 0000H
        CLR C
        MOV R5, #04H
        MOV R0, #30H
        MOV R1, #10H
        MOV R2, #00H
        MOV R3, #11H
        MOV R4, #00H
        MOV 30H, #11H
        MOV 31H, #45H
        MOV 32H, #14H
        MOV 33H, #99H
        MOV DPTR, #1000H
        MOV A, #19H
L0:     MOVX @DPTR, A
        INC DPTR
        DJNZ R5, L0
        MOV R5, #04H 
L1:     MOV DPH, R1
        MOV DPL, R2
        MOVX A, @DPTR
        ADDC A, @R0
        DA A
        MOV DPH, R3
        MOV DPL, R4
        MOVX @DPTR, A
        INC R2
        INC R4
        INC R0
L2:     DJNZ R5, L1
        JNC L3
        MOV DPTR, #1104H
        MOV A, #01H
        MOVX @DPTR, A
L3:     NOP
        SJMP $
        END
        
        
                
