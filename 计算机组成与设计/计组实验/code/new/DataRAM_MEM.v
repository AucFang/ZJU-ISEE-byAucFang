`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/22 10:44:46
// Design Name: 
// Module Name: DataRAM_MEM
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


module DataRAM_MEM(
    //Input
    clk,
    ram_wea,    //write enable
    ram_addr,   //ram read/write addr
    ram_wr_data, //ram write data
    //Output
    ram_rd_data  //ram read data
    );
    input clk,ram_wea;
    input [5:0] ram_addr;
    input [31:0] ram_wr_data;
    output  [31:0] ram_rd_data;
    DataRAM RAM1 (
      .a(ram_addr),      // input wire [5 : 0] a
      .d(ram_wr_data),      // input wire [31 : 0] d
      .clk(clk),  // input wire clk
      .we(ram_wea),    // input wire we
      .spo(ram_rd_data)  // output wire [31 : 0] spo
    );
endmodule
