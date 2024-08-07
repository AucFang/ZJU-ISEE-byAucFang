`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/22 11:36:54
// Design Name: 
// Module Name: mux4bits
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


module mux4bits(
    input [3:0] inA,
    input [3:0] inB,
    input sel,
    output [3:0] muxOut
    );
    assign muxOut = sel ? inA : inB;
endmodule
