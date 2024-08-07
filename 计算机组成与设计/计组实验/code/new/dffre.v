`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/18 08:47:09
// Design Name: 
// Module Name: dffre
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

module dffre(d, en, reset, clk, q);
parameter n = 1; //寄存器位数，n=1为D触发器
input en, reset, clk;
input [n-1:0] d;
output [n-1:0] q;
reg [n-1:0] q;
always @(posedge clk) begin
    if(reset) begin
        q= {n{1'b0}};
    end
    else begin
        q = en? d:q;
    end
end
endmodule