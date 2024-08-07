        CS0832 EQU 0A000H

        MOV DPTR, #CS0832
        MOV A, #00H
        MOVX @DPTR, A
        MOV A, #40H
        MOVX @DPTR, A
        MOV A, #80H
        MOVX @DPTR, A
        MOV A, #0C0H
        MOVX @DPTR, A
        MOV A, #0FFH
        MOVX @DPTR, A
        LJMP 0
        END
