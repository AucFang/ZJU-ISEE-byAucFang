	ORG 0000H
        MOV DPTR, #TABLE
        MOV R3, #25
        MOV A, R3
	DEC A
	RL A		;调整A以适应表中数据分布（一个平方数2字节）
	MOV R2, A	;保存A
	MOVC A, @A+DPTR	;查表得高八位
	MOV R6, A	;储存高八位
	MOV A, R2	;恢复A
	INC A		;修正A
	MOVC A, @A+DPTR	;查表得低八位
	MOV R7, A	;储存低八位
	SJMP $
	ORG 2000H
TABLE:	DW 1,4,9,16,25,36,49,64,81,100
	DW 121,144,169,196,225,256,289,324,361,400
        DW 441,484,529,576,625,676,729,784,841
END
