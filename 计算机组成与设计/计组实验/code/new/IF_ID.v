`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/22 12:21:40
// Design Name: 
// Module Name: IF_ID
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


module IF_ID (clk, en, reset, PC_if, Instruction_if, PC_id, Instruction_id);
    input clk, en, reset;
    input[31:0] PC_if, Instruction_if;
    output [31:0] PC_id, Instruction_id;
    
    dffre #(.n(32)) PC_dffre (.d(PC_if),.q(PC_id),.clk(clk),.en(en),.reset(reset));
    dffre #(.n(32)) Inst_dffre (.d(Instruction_if),.q(Instruction_id),.clk(clk),.en(en),.reset(reset));
    
endmodule
