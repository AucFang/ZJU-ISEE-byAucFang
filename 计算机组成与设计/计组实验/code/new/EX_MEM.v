`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/29 09:16:49
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM (clk,
    MemtoReg_ex, RegWrite_ex, MemWrite_ex, ALUResult_ex, MemWriteData_ex, rdAddr_ex,
    MemtoReg_mem, RegWrite_mem, MemWrite_mem, ALUResult_mem, MemWriteData_mem, rdAddr_mem
    );
    input clk;
    input MemtoReg_ex, RegWrite_ex, MemWrite_ex;
    input[31:0] ALUResult_ex, MemWriteData_ex;
    input[4:0] rdAddr_ex;

    output reg MemtoReg_mem, RegWrite_mem, MemWrite_mem;
    output reg [31:0] ALUResult_mem, MemWriteData_mem;
    output reg [4:0] rdAddr_mem;

    always@(posedge clk)
    begin
        MemtoReg_mem <= MemtoReg_ex;
        RegWrite_mem <= RegWrite_ex;
        MemWrite_mem <= MemWrite_ex;
        ALUResult_mem <= ALUResult_ex;
        MemWriteData_mem <=MemWriteData_ex;
        rdAddr_mem <= rdAddr_ex;
    end    
endmodule
