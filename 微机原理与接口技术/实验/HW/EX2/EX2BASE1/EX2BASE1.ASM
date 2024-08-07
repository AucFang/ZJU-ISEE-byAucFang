        ORG 0000H
        MOV TMOD, #01H
LOOP1:  MOV R0, #0AH
LOOP2:  MOV TL0, #0F0H
        MOV TH0, #0D8H
        SETB TR0
        JNB TF0,$
        CLR TF0
        DJNZ R0,LOOP2
        CPL P1.0
        SJMP LOOP1
        END
