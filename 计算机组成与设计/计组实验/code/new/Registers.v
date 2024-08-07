`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/01 08:25:32
// Design Name: 
// Module Name: Registers
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


module Registers(clk, rs1Addr, rs2Addr, WriteAddr, RegWrite, WriteData, rs1Data, rs2Data);
input clk;
input [4:0] rs1Addr, rs2Addr, WriteAddr;
input RegWrite;
input [31:0] WriteData;
output [31:0] rs1Data, rs2Data;
    wire rs1Sel, rs2Sel;    //转发检测电路输出
    wire [31:0] ReadData1, ReadData2;
    RBWRegisters RBWRegisters_1(.clk(clk),.ReadRegister1(rs1Addr), .ReadRegister2(rs2Addr),.WriteRegister(WriteAddr),.WriteData(WriteData),.RegWrite(RegWrite),.ReadData1(ReadData1),.ReadData2(ReadData2));
    assign rs1Sel = RegWrite && (WriteAddr != 0) && (WriteAddr == rs1Addr);
    assign rs2Sel = RegWrite && (WriteAddr != 0) && (WriteAddr == rs2Addr);
    
    //output
    assign rs1Data = rs1Sel? WriteData:ReadData1;
    assign rs2Data = rs2Sel? WriteData:ReadData2;
endmodule
