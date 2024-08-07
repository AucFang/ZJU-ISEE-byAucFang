        ORG 0000H
LOOP:   MOV A, #01H
        MOV R2,#8
OUTPUT: MOV P1,A
        RL A
        ACALL DELAY
        DJNZ R2,OUTPUT
        LJMP LOOP
        SJMP $
DELAY:  MOV R6,#0; —” ±≥Ã–Ú
        MOV R7,#0
DLOOP:  DJNZ R6,DLOOP
        DJNZ R7,DLOOP
        RET
        END
