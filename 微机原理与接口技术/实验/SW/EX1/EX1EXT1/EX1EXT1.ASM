        ORG 0000H
	MOV R0,#30H
	MOV R1,#40H
	MOV R2,#10H
L1:	MOV A ,@R0
	MOV @R1,A
	INC R0
	INC R1
	DJNZ R2,L1
        SJMP $
	END
