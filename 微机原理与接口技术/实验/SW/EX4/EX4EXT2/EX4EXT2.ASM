        MAX EQU 20H
        MIN EQU 21H
        ORG 0000H
        MOV DPTR, #1000H
        MOV R2, #10H
        MOVX A, @DPTR
        MOV MAX, A
        MOV MIN, A
LOOP:   MOVX A, @DPTR
        MOV B, MAX
        MOV C, ACC.7
        ANL C, /B.7             ;新的数为负数而MAX为正数
        JC MAXPS
        MOV C, B.7
        ANL C, /ACC.7           ;新的数为正数而MAX为负数
        JC CGE1      
        CLR C
        SUBB A, MAX             
        JC MAXPS                ;(A)<(MAX)
        MOVX A, @DPTR
CGE1:   MOV MAX, A
        LJMP MAXPS
MAXPS:  MOVX A, @DPTR
        MOV B, MIN
        MOV C, ACC.7            
        ANL C, /B.7             ;新的数为负数而MIN为正数
        JC CGE2
        MOV C, B.7
        ANL C, /ACC.7           ;新的数为正数而MIN为负数
        JC MINPS
        CLR C
        MOVX A, @DPTR
        SUBB A, MIN             
        JNC MINPS               ;(A)>(MIN)
        MOVX A, @DPTR
CGE2:   MOV MIN, A
        LJMP MINPS
MINPS:  INC DPTR
        DJNZ R2, LOOP
        SJMP $
        END
        
         
        
