`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/01 08:13:55
// Design Name: 
// Module Name: mux2
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


module mux2 (in0, in1, sel, out);
    // two to one
    parameter n = 4;
    input[n-1:0] in0, in1;
    input sel;
    output[n-1:0] out;

    assign out = sel?in1:in0;
endmodule
