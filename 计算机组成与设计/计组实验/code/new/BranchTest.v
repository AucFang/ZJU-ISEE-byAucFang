`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/01 11:27:34
// Design Name: 
// Module Name: BranchTest
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


module BranchTest (Instruction, rs1Data, rs2Data, Branch);
    input[31:0] Instruction, rs1Data, rs2Data;
    output reg Branch;
    
    parameter SB_opcode=  7'b1100011;
    parameter beq_funct3 = 3'o0;
    parameter bne_funct3 = 3'o1;
    parameter blt_funct3 = 3'o4;
    parameter bge_funct3 = 3'o5;
    parameter bltu_funct3 = 3'o6;
    parameter bgeu_funct3 = 3'o7;
    
    wire[31:0] sum;
    wire[6:0] op;
    wire[2:0] funct3;
    wire isLT, isLTU, SB_type;

    assign op = Instruction[6:0];
    assign funct3 = Instruction[14:12];
    assign SB_type = (op == SB_opcode);

    Adder32bits adder(.inA(rs1Data), .inB(~rs2Data), .cin(1), .addOut(sum), .cout());
    assign isLT = (rs1Data[31]&&(~rs2Data[31])) || ((rs1Data[31]~^rs2Data[31])&&sum[31]);
    assign isLTU = ((~rs1Data[31])&&rs2Data[31]) || ((rs1Data[31]~^rs2Data[31])&&sum[31]); 
    
    always@(*) begin
        if(SB_type && (funct3 == beq_funct3)) begin Branch = ~(|sum[31:0]); end
        else if(SB_type && (funct3 == bne_funct3)) begin Branch = |sum[31:0]; end
        else if(SB_type && (funct3 == blt_funct3)) begin Branch = isLT; end
        else if(SB_type && (funct3 == bge_funct3)) begin Branch = ~isLT; end
        else if(SB_type && (funct3 == bltu_funct3)) begin Branch = isLTU; end
        else if(SB_type && (funct3 == bgeu_funct3)) begin Branch = ~isLTU; end
        else begin Branch = 0; end             
    end
    
endmodule