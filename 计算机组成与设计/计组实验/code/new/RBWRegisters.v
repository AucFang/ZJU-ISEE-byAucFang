`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/01 08:30:41
// Design Name: 
// Module Name: RBWRegisters
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


module RBWRegisters(clk, ReadRegister1, ReadRegister2, WriteRegister, RegWrite, WriteData, ReadData1, ReadData2);
input clk;
input [4:0] ReadRegister1, ReadRegister2, WriteRegister; //读/写寄存器位置
input [31:0] WriteData;
input RegWrite;
output [31:0] ReadData1, ReadData2;
    reg [31:0]regs [31:0]; //定义32*32存储器变量
    assign ReadData1 = (ReadRegister1 == 5'b0)? 32'b0 : regs[ReadRegister1]; //端口1数据读出
    assign ReadData2 = (ReadRegister2 == 5'b0)? 32'b0 : regs[ReadRegister2]; //端口2数据读出 
    always @(posedge clk)
        if(RegWrite) regs[WriteRegister] <= WriteData; 
endmodule
