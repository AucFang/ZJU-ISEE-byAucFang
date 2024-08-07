        ORG 0000H
        MOV R3, #03H
        MOV R0, #30H
        MOV R1, #40H
        MOV R2, #50H
        CLR C
L1:     MOV A, @R0      ;Get sourse data
        SUBB A, @R1
        MOV B, R1       ;Protect R1
        MOV R1, 02H
        MOV @R1, A      ;Store result
        INC R2          ;Change objective address 
        MOV R1, B       ;Restore R1
        INC R1          ;Change sourse data address
        INC R0
L2:     DJNZ R3, L1     ;loop
        JNZ L3
        MOV R1, #53H
        MOV @R1,#0FFH
L3:     NOP
        SJMP $
        END
        
        
         
