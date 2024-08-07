`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/29 08:58:02
// Design Name: 
// Module Name: ID_EX
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


module ID_EX (clk, reset, 
    MemtoReg_id, RegWrite_id, MemWrite_id, MemRead_id, ALUCode_id, ALUSrcA_id, ALUSrcB_id, PC_id, Imm_id, rdAddr_id, rs1Addr_id, rs2Addr_id, rs1Data_id, rs2Data_id, 
    MemtoReg_ex, RegWrite_ex, MemWrite_ex, MemRead_ex, ALUCode_ex, ALUSrcA_ex, ALUSrcB_ex, PC_ex, Imm_ex, rdAddr_ex, rs1Addr_ex, rs2Addr_ex, rs1Data_ex, rs2Data_ex);

    input clk, reset, ALUSrcA_id, MemtoReg_id, RegWrite_id, MemWrite_id, MemRead_id;
	input[3:0] ALUCode_id;
	input[1:0] ALUSrcB_id;
	input[31:0] PC_id, Imm_id, rs1Data_id, rs2Data_id;
	input[4:0] rdAddr_id, rs1Addr_id, rs2Addr_id;

    output ALUSrcA_ex, MemtoReg_ex, RegWrite_ex, MemWrite_ex, MemRead_ex;
	output [3:0] ALUCode_ex;
	output [1:0] ALUSrcB_ex;
	output [31:0] PC_ex, Imm_ex, rs1Data_ex, rs2Data_ex;
	output [4:0] rdAddr_ex, rs1Addr_ex, rs2Addr_ex;

    dffre #(.n(1)) MemtoReg_dffre (.d(MemtoReg_id),.q(MemtoReg_ex),.clk(clk),.en(1),.reset(reset));
    dffre #(.n(1)) RegWrite_dffre (.d(RegWrite_id),.q(RegWrite_ex),.clk(clk),.en(1),.reset(reset));
    dffre #(.n(1)) MemWrite_dffre (.d(MemWrite_id),.q(MemWrite_ex),.clk(clk),.en(1),.reset(reset));
    dffre #(.n(1)) MemRead_dffre (.d(MemRead_id),.q(MemRead_ex),.clk(clk),.en(1),.reset(reset));
    dffre #(.n(4)) ALUCode_dffre (.d(ALUCode_id),.q(ALUCode_ex),.clk(clk),.en(1),.reset(reset));
    dffre #(.n(1)) ALUSrcA_dffre (.d(ALUSrcA_id),.q(ALUSrcA_ex),.clk(clk),.en(1),.reset(reset));
    dffre #(.n(2)) ALUSrcB_dffre (.d(ALUSrcB_id),.q(ALUSrcB_ex),.clk(clk),.en(1),.reset(reset));
    dffre #(.n(5)) rdAddr_dffre (.d(rdAddr_id),.q(rdAddr_ex),.clk(clk),.en(1),.reset(reset));
    dffre #(.n(5)) rs1Addr_dffre (.d(rs1Addr_id),.q(rs1Addr_ex),.clk(clk),.en(1),.reset(reset));
    dffre #(.n(5)) rs2Addr_dffre (.d(rs2Addr_id),.q(rs2Addr_ex),.clk(clk),.en(1),.reset(reset));
    dffre #(.n(32)) rs1Data_dffre (.d(rs1Data_id),.q(rs1Data_ex),.clk(clk),.en(1),.reset(reset));
    dffre #(.n(32)) rs2Data_dffre (.d(rs2Data_id),.q(rs2Data_ex),.clk(clk),.en(1),.reset(reset));
    dffre #(.n(32)) PC_dffre (.d(PC_id),.q(PC_ex),.clk(clk),.en(1),.reset(reset));
    dffre #(.n(32)) Imm_dffre (.d(Imm_id),.q(Imm_ex),.clk(clk),.en(1),.reset(reset));
    
endmodule
