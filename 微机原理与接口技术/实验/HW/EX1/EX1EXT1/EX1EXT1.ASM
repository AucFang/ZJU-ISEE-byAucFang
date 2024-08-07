        ORG 0000H
LOOP:   MOV A, #055H
        MOV R2,#2H
OUTPUT: MOV P1, A
        RL A
        ACALL DELAY
        DJNZ R2, OUTPUT
        LJMP LOOP
DELAY:  MOV R6, #0AH
DLY1:   MOV R5, #0C8H
DLY2:   MOV R4, #0F9H
DLY3:   DJNZ R4, DLY3
        DJNZ R5, DLY2
        DJNZ R6, DLY1
        RET
        END
