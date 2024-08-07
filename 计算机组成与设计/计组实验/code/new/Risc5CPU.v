`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/29 09:22:58
// Design Name: 
// Module Name: Risc5CPU
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


module Risc5CPU(clk, reset, JumpFlag, Instruction_id, ALU_A, ALU_B, ALUResult_ex, PC, MemDout_mem,Stall);
    input clk;
    input reset;
    output[1:0] JumpFlag;
    output [31:0] Instruction_id;
    output [31:0] ALU_A;
    output [31:0] ALU_B;
    output [31:0] ALUResult_ex;
    output [31:0] PC;
    output [31:0] MemDout_mem;
    output Stall;

    //IF级连线
    //input clk, reset;
    wire Branch,Jump, IFWrite, IF_flush;
    wire[31:0] JumpAddr;
    wire[31:0] Instruction_if, PC;
    assign Branch = JumpFlag[0];
    assign Jump = JumpFlag[1];
    
    //ID级信号
    //input clk;
    //input [31:0] Instruction_id;
    //output stall
    //wire RegWrite_wb, MemRead_ex, Branch, Jump, IFWrite;
    //wire [4:0] rdAddr_wb, rdAddr_ex;
    //wire [31:0] RegWriteData_wb, JumpAddr;
    wire [31:0] PC_id, Imm_id, rs1Data_id, rs2Data_id;
	wire MemtoReg_id, RegWrite_id, MemWrite_id, MemRead_id;
	wire[3:0] ALUCode_id;
	wire ALUSrcA_id;
	wire[1:0] ALUSrcB_id;
	wire[4:0] rdAddr_id, rs1Addr_id, rs2Addr_id;

    //EX级信号
    //wire [31:0] RegWriteData_wb, ALUResult_mem;
    //wire [4:0] rdAddr_mem, rdAddr_wb;
    //wire RegWrite_mem, RegWrite_wb;
    //output [31:0] ALU_A, ALU_B
    wire [3:0] ALUCode_ex;
    wire ALUSrcA_ex,MemtoReg_ex, RegWrite_ex, MemWrite_ex, MemRead_ex;
	wire [1:0] ALUSrcB_ex;
	wire [4:0] rs1Addr_ex, rs2Addr_ex, rdAddr_ex;
    wire [31:0] Imm_ex, rs1Data_ex, rs2Data_ex, PC_ex, ALUResult_ex, MemWriteData_ex;

    //MEM级信号
    wire MemtoReg_mem, RegWrite_mem, MemWrite_mem;
    wire [31:0] ALUResult_mem, MemWriteData_mem;
    wire [4:0] rdAddr_mem;

    //WB级信号
    wire MemtoReg_wb, RegWrite_wb;
    wire [31:0] MemDout_wb, ALUResult_wb, RegWriteData_wb;
    wire [4:0] rdAddr_wb;

    IF IFStage(
        //input
        .clk(clk), 
        .reset(reset), 
        .Branch(Branch),
        .Jump(Jump), 
        .IFWrite(IFWrite), 
        .JumpAddr(JumpAddr),
        //output
        .Instruction_if(Instruction_if),
        .PC(PC),
        .IF_flush(IF_flush)
    );

    IF_ID IF_ID_REG(
        //input
        .clk(clk), 
        .en(IFWrite), 
        .reset(IF_flush|reset), 
        .PC_if(PC), 
        .Instruction_if(Instruction_if), 
        //output
        .PC_id(PC_id), 
        .Instruction_id(Instruction_id)
    );

    ID IDStage(
        //input
        .clk(clk),
        .Instruction_id(Instruction_id), 
        .PC_id(PC_id), 
        .RegWrite_wb(RegWrite_wb), 
        .rdAddr_wb(rdAddr_wb), 
        .RegWriteData_wb(RegWriteData_wb), 
        .MemRead_ex(MemRead_ex), 
        .rdAddr_ex(rdAddr_ex), 
        //output
        .MemtoReg_id(MemtoReg_id), 
        .RegWrite_id(RegWrite_id), 
        .MemWrite_id(MemWrite_id), 
        .MemRead_id(MemRead_id), 
        .ALUCode_id(ALUCode_id), 
	    .ALUSrcA_id(ALUSrcA_id), 
        .ALUSrcB_id(ALUSrcB_id),  
        .Stall(Stall), 
        .Branch(JumpFlag[0]), 
        .Jump(JumpFlag[1]), 
        .IFWrite(IFWrite),  
        .JumpAddr(JumpAddr), 
        .Imm_id(Imm_id),
		.rs1Data_id(rs1Data_id), 
        .rs2Data_id(rs2Data_id),
        .rs1Addr_id(rs1Addr_id),
        .rs2Addr_id(rs2Addr_id),
        .rdAddr_id(rdAddr_id)
    );

    ID_EX ID_EX_REG(
        //input
        .clk(clk), 
        .reset(Stall|reset), 
        .MemtoReg_id(MemtoReg_id), 
        .RegWrite_id(RegWrite_id), 
        .MemWrite_id(MemWrite_id), 
        .MemRead_id(MemRead_id), 
        .ALUCode_id(ALUCode_id), 
        .ALUSrcA_id(ALUSrcA_id), 
        .ALUSrcB_id(ALUSrcB_id), 
        .PC_id(PC_id), 
        .Imm_id(Imm_id), 
        .rdAddr_id(rdAddr_id), 
        .rs1Addr_id(rs1Addr_id), 
        .rs2Addr_id(rs2Addr_id), 
        .rs1Data_id(rs1Data_id), 
        .rs2Data_id(rs2Data_id),
        //output
        .MemtoReg_ex(MemtoReg_ex), 
        .RegWrite_ex(RegWrite_ex), 
        .MemWrite_ex(MemWrite_ex), 
        .MemRead_ex(MemRead_ex), 
        .ALUCode_ex(ALUCode_ex), 
        .ALUSrcA_ex(ALUSrcA_ex), 
        .ALUSrcB_ex(ALUSrcB_ex), 
        .PC_ex(PC_ex), 
        .Imm_ex(Imm_ex), 
        .rdAddr_ex(rdAddr_ex), 
        .rs1Addr_ex(rs1Addr_ex), 
        .rs2Addr_ex(rs2Addr_ex), 
        .rs1Data_ex(rs1Data_ex), 
        .rs2Data_ex(rs2Data_ex)
    );

    EX EXStage(
        //input
        .ALUCode_ex(ALUCode_ex), 
        .ALUSrcA_ex(ALUSrcA_ex), 
        .ALUSrcB_ex(ALUSrcB_ex),
        .Imm_ex(Imm_ex), 
        .rs1Addr_ex(rs1Addr_ex), 
        .rs2Addr_ex(rs2Addr_ex), 
        .rs1Data_ex(rs1Data_ex), 
        .rs2Data_ex(rs2Data_ex), 
        .PC_ex(PC_ex), 
        .RegWriteData_wb(RegWriteData_wb), 
        .ALUResult_mem(ALUResult_mem),
        .rdAddr_mem(rdAddr_mem), 
        .rdAddr_wb(rdAddr_wb), 
		.RegWrite_mem(RegWrite_mem), 
        .RegWrite_wb(RegWrite_wb), 
        //output
        .ALUResult_ex(ALUResult_ex), 
        .MemWriteData_ex(MemWriteData_ex), 
        .ALU_A(ALU_A), 
        .ALU_B(ALU_B)
    );

    EX_MEM EX_MEM_REG(
        //input
        .clk(clk),
        .MemtoReg_ex(MemtoReg_ex), 
        .RegWrite_ex(RegWrite_ex), 
        .MemWrite_ex(MemWrite_ex), 
        .ALUResult_ex(ALUResult_ex), 
        .MemWriteData_ex(MemWriteData_ex), 
        .rdAddr_ex(rdAddr_ex),
        //output
        .MemtoReg_mem(MemtoReg_mem), 
        .RegWrite_mem(RegWrite_mem), 
        .MemWrite_mem(MemWrite_mem), 
        .ALUResult_mem(ALUResult_mem), 
        .MemWriteData_mem(MemWriteData_mem), 
        .rdAddr_mem(rdAddr_mem)
    );

    DataRAM_MEM DataRAM_1(
        //input
        .ram_addr(ALUResult_mem[7:2]),
        .ram_wr_data(MemWriteData_mem),
        .clk(clk),
        .ram_wea(MemWrite_mem),
        //output
        .ram_rd_data(MemDout_mem)
    );

    MEM_WB MEM_WB_REG(
        //input
        .clk(clk),
        .MemtoReg_mem(MemtoReg_mem), 
        .RegWrite_mem(RegWrite_mem), 
        .MemDout_mem(MemDout_mem), 
        .ALUResult_mem(ALUResult_mem), 
        .rdAddr_mem(rdAddr_mem),
        //output
        .MemtoReg_wb(MemtoReg_wb), 
        .RegWrite_wb(RegWrite_wb), 
        .MemDout_wb(MemDout_wb), 
        .ALUResult_wb(ALUResult_wb), 
        .rdAddr_wb(rdAddr_wb)
    );

    assign RegWriteData_wb = MemtoReg_wb?MemDout_wb:ALUResult_wb;

endmodule
