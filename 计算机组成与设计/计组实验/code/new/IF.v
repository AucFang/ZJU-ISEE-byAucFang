`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/22 11:02:01
// Design Name: 
// Module Name: IF
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module IF(clk, reset, Branch,Jump,IFWrite, JumpAddr,Instruction_if,PC,IF_flush);
    input clk;
    input reset;
    input Branch;
    input Jump;
    input IFWrite;
    input [31:0] JumpAddr;
    output IF_flush;
    output [31:0] Instruction_if;
    output reg [31:0]PC;

    wire[31:0] NextPC_if, PC_tmp;
    assign IF_flush = Branch || Jump;
    assign PC_tmp = IF_flush?JumpAddr:NextPC_if;
    always@(posedge clk)
    begin
        if(reset) PC <= 0;
        else if(~IFWrite) PC <= PC;
        else PC <= PC_tmp;
    end

    Adder32bits PCadder (.inA(PC),.inB(32'd4),.cin(0),.addOut(NextPC_if),.cout());
    InstructionROM InstROM (.addr(PC[7:2]),.dout(Instruction_if));

endmodule



