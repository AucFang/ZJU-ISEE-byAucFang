        ORG 0000H
        MOV P2, #00H    ;设置高八位地址为0
        MOV R0, #30H    ;设置R0
        MOV R1, #50H    ;设置R1
        MOV R2, #20H    ;设置R2
L1:     MOVX A, @R0     ;将R0指向的内容赋值给A
        MOVX @R1, A     ;将A的内容赋值给R1指向的地址
        INC R0          ;R0自增改变地址
        INC R1          ;R1自增改变地址
        DJNZ R2, L1     ;循环判断
        SJMP $
        END             ;程序功能：将外部RAM中30H到4FH中的内容复制到50H到6FH
