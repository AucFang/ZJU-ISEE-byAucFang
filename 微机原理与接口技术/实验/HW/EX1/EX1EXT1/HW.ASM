        MOV SP, #5FH
        MOV R7, #08H
        MOV R0, #3FH
LOOP:   POP A
        MOV @R0, A
        DEC R0
        DJNZ R7, LOOP
        SJMP $
