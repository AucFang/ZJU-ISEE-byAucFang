`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/15 09:31:44
// Design Name: 
// Module Name: ALU
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


module ALU (
	// Outputs
	   ALUResult,
	// Inputs
	   ALUCode, A, B);
	input [3:0]	ALUCode;				// Operation select
	input [31:0]	A, B;
	output [31:0]	ALUResult;
	
// Decoded ALU operation select (ALUsel) signals
   parameter	 alu_add=  4'b0000;
   parameter	 alu_sub=  4'b0001;
   parameter	 alu_lui=  4'b0010;
   parameter	 alu_and=  4'b0011;
   parameter	 alu_xor=  4'b0100;
   parameter	 alu_or =  4'b0101;
   parameter 	 alu_sll=  4'b0110;
   parameter	 alu_srl=  4'b0111;
   parameter	 alu_sra=  4'b1000;
   parameter	 alu_slt=  4'b1001;
   parameter	 alu_sltu= 4'b1010; 
   
   wire Binvert;
   reg  [31:0] ALUResult;
   reg signed[31:0] A_reg;
   wire [31:0] sum;
   wire slt_rst, sltu_rst;

   assign Binvert = ~(ALUCode == 0);
   Adder32bits adder1(.inA(A),.inB({32{Binvert}}^B),.cin(Binvert),.addOut(sum),.cout());
   assign slt_rst = A[31]&&(~B[31]) || (A[31]~^B[31])&&sum[31];
   assign sltu_rst = (~A[31])&&B[31] || (A[31]~^B[31])&&sum[31];
   
   always @(*) begin
        A_reg = A;
        case (ALUCode)
            alu_add: ALUResult = sum;
            alu_sub: ALUResult = sum;
            alu_lui: ALUResult = B;
            alu_and: ALUResult = A&B;
            alu_xor: ALUResult = A^B;
            alu_or:  ALUResult = A|B;
            alu_sll: ALUResult = A<<B;
            alu_srl: ALUResult = A>>B;
            alu_sra: ALUResult = A_reg >>>B; 
            //alu_sra: ALUResult = ($signed(A)) >>> B; 
            alu_slt: ALUResult = slt_rst?32'd1:32'd0;
            alu_sltu: ALUResult = sltu_rst?32'd1:32'd0;
            default: ALUResult = sum;
        endcase
   end
endmodule
