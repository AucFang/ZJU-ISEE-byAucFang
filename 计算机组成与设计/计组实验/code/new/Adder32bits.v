`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/22 11:38:42
// Design Name: 
// Module Name: Adder32bits
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


module Adder32bits(
    input [31:0] inA,
    input [31:0] inB,
    input cin,
    output [31:0] addOut,
    output cout
    );
    wire c3,c70,c71,and1out,c7,c111,c110,and2out,c11,c151,c150,and3out,c15,c191,c190,and4out,c19,c231,c230,and5out,c23,c271,c270,and6out,c27;
    wire [3:0]adder21, adder30, adder41, adder50,adder61,adder70,adder81,adder90,adder101,adder110,adder121,adder130,adder141,adder150;
    wire c311,c310,and7out;
    /*bits 3:0*/
    Adder4bits Adder1 (.inA(inA[3:0]),.inB(inB[3:0]),.cin(cin),.addOut(addOut[3:0]),.cout(c3));
    
    /*bits 7:4*/
    Adder4bits Adder2 (.inA(inA[7:4]),.inB(inB[7:4]),.cin(1'b1),.addOut(adder21),.cout(c71));
    Adder4bits Adder3 (.inA(inA[7:4]),.inB(inB[7:4]),.cin(1'b0),.addOut(adder30),.cout(c70));
    mux4bits Mux1(.inA(adder21),.inB(adder30),.sel(c3),.muxOut(addOut[7:4]));
    and and1(and1out,c3,c71);
    or or1(c7,and1out,c70);
    
    /*bits 11:8*/
    Adder4bits Adder4 (.inA(inA[11:8]),.inB(inB[11:8]),.cin(1'b1),.addOut(adder41),.cout(c111));
    Adder4bits Adder5 (.inA(inA[11:8]),.inB(inB[11:8]),.cin(1'b0),.addOut(adder50),.cout(c110));
    mux4bits Mux2(.inA(adder41),.inB(adder50),.sel(c7),.muxOut(addOut[11:8]));
    and and2(and2out,c7,c111);
    or or2(c11,and2out,c110);
    
    /*bits 15:12*/
    Adder4bits Adder6 (.inA(inA[15:12]),.inB(inB[15:12]),.cin(1'b1),.addOut(adder61),.cout(c151));
    Adder4bits Adder7 (.inA(inA[15:12]),.inB(inB[15:12]),.cin(1'b0),.addOut(adder70),.cout(c150));
    mux4bits Mux3(.inA(adder61),.inB(adder70),.sel(c11),.muxOut(addOut[15:12]));
    and and3(and3out,c11,c151);
    or or3(c15,and3out,c150);
    
    /*bits 19:16*/
    Adder4bits Adder8 (.inA(inA[19:16]),.inB(inB[19:16]),.cin(1'b1),.addOut(adder81),.cout(c191));
    Adder4bits Adder9 (.inA(inA[19:16]),.inB(inB[19:16]),.cin(1'b0),.addOut(adder90),.cout(c190));
    mux4bits Mux4(.inA(adder81),.inB(adder90),.sel(c15),.muxOut(addOut[19:16]));
    and and4(and4out,c15,c191);
    or or4(c19,and4out,c190);
    
    /*bits 23:20*/
    Adder4bits Adder10 (.inA(inA[23:20]),.inB(inB[23:20]),.cin(1'b1),.addOut(adder101),.cout(c231));
    Adder4bits Adder11 (.inA(inA[23:20]),.inB(inB[23:20]),.cin(1'b0),.addOut(adder110),.cout(c230));
    mux4bits Mux5(.inA(adder101),.inB(adder110),.sel(c19),.muxOut(addOut[23:20]));
    and and5(and5out,c19,c231);
    or or5(c23,and5out,c230);
    
    /*bits 27:24*/
    Adder4bits Adder12 (.inA(inA[27:24]),.inB(inB[27:24]),.cin(1'b1),.addOut(adder121),.cout(c271));
    Adder4bits Adder13 (.inA(inA[27:24]),.inB(inB[27:24]),.cin(1'b0),.addOut(adder130),.cout(c270));
    mux4bits Mux6(.inA(adder121),.inB(adder130),.sel(c23),.muxOut(addOut[27:24]));
    and and6(and6out,c23,c271);
    or or6(c27,and6out,c270);
    
    /*bits 31:28*/
    Adder4bits Adder14 (.inA(inA[31:28]),.inB(inB[31:28]),.cin(1'b1),.addOut(adder141),.cout(c311));
    Adder4bits Adder15 (.inA(inA[31:28]),.inB(inB[31:28]),.cin(1'b0),.addOut(adder150),.cout(c310));
    mux4bits Mux7(.inA(adder141),.inB(adder150),.sel(c27),.muxOut(addOut[31:28]));
    and and7(and7out,c27,c311);
    or or7(cout,and7out,c310);
endmodule

