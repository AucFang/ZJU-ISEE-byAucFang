        ORG 0000H
        MOV R0, #30H    ;SET HEAD ADDRESS
        MOV 30H, #41H   ;(30H) = 'A'
        MOV 31H, #5AH   ;(31H) = 'Z'
        MOV 32H, #66H
        MOV 33H, #61H   ;(33H) = 'a'
        MOV 34H, #4CH   ;(34H) = 'L'
        MOV R1, #06H 
LOOP:   CJNE @R0, #41H, NEXT1
NEXT1:  JC LAST         ;LESS THAN 41H('A'), NOT CHANGE
        MOV 02H, @R0
        DEC R2
        CJNE R2, #5AH, NEXT2
NEXT2:  JNC LAST        ;BIG THAN 5AH('Z'),NOT CHANGE
        MOV A, #20H
        ADD A, @R0
        MOV @R0, A
LAST:   INC R0
        DJNZ R1, LOOP
        SJMP $
        END
