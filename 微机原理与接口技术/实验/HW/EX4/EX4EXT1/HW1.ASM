        ORG 0000H
START:  MOV SP, #20H
        MOV 30H, #0FFH
MLP0:   MOV A, 30H
        CJNE A, #08H, MLP1
        MOV A, #00H
MLP2:   MOV 30H, A
        MOV DPTR, #ITAB
        MOVC A, @A+DPTR
        MOV P1, A
        SJMP MLP0
MLP1:   INC A
        SJMP MLP2
ITAB:   DB 1,2,4,8
        DB 8,4,2,1
