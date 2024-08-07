	ORG 0000H
	MOV R0, #3FH		;工作寄存器R0指向源数据末地址
	MOV DPTR, #0000H	;DPTR指向目的地址
	MOV R7, #10H		;传送的字节数
MLP:	MOV A, @R0		;取出源数据
	MOVX @DPTR, A		;送入目标地址
	DEC R0			;改变源地址指针
	INC DPTR		;改变目标地址指针
	DJNZ R7, MLP		;未完成则循环
	NOP
        SJMP $
