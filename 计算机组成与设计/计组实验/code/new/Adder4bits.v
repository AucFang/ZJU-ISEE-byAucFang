`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/22 11:37:57
// Design Name: 
// Module Name: Adder4bits
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


module Adder4bits(
    input [3:0] inA,
    input [3:0] inB,
    input cin,
    output reg [3:0] addOut,
    output reg cout
    );
    wire [3:0] G;
    wire [3:0] P;
    reg [3:0] C;
    assign G = inA & inB;
    assign P = inA | inB;
    always@(*)
        begin
            C[0] <= cin;
            C[1] <= G[0] | (P[0] & C[0]);
            C[2] <= G[1] | (P[1] & C[1]);
            C[3] <= G[2] | (P[2] & C[2]);
            cout <= G[3] | (P[3] & C[3]);
            addOut <= G^P^C;
        end
endmodule
