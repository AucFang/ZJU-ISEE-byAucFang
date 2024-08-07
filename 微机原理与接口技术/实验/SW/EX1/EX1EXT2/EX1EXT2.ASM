	ORG 0000H
	MOV R0, #30H	;工作寄存器R0指向源数据首地址
	MOV DPTR, #1030H;DPTR指向目的地址
	MOV R7, #10H	;传送的字节数
MLP:	MOV A, @R0	;取出源数据
	MOVX @DPTR, A	;送入目标地址
	INC R0		;修正源地址指针
	INC DPTR	;修正目标地址指针
	DJNZ R7, MLP	;未完成则循环
	NOP		;结束
        SJMP $
	END
