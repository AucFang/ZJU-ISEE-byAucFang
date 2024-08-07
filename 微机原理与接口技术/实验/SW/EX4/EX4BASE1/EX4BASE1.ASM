        ORG 0000H
        MOV R2, #10H
        MOV DPTR, #TBL
L0:     MOV A, #00H
        MOVC A, @A+DPTR
        INC DPTR
        DJNZ R2, L0
        SJMP $
TBL:    DB 3FH, 06H, 5BH, 4FH, 66H, 6DH
        DB 7DH, 07H, 7FH, 6FH, 77H, 7CH
        DB 58H, 5EH, 79H, 71H, 00H, 40H
        END     
