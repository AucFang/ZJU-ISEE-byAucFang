RESULT EQU 30H
ORG 0000H
MOV A, #0D8H
MOV B, #64H
DIV AB
MOV RESULT, A;除以100得百位数
MOV A, B
MOV B, #0AH
DIV AB
MOV RESULT+1, A;除以10得十位数
MOV RESULT+2, B;余数为个位数
SJMP $
END
