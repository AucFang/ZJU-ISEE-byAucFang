`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer: qmj	
//////////////////////////////////////////////////////////////////////////////////

module PipelineCPUTest(  
    input  clk,  // 100MHz 
    input reset, //BTNC
	input step,  //BTNU
	input run_mode,//SW0:
    output [2:0] TMDSp, TMDSn,  
    output TMDSp_clk, TMDSn_clk  
);  
//DCM实例
 wire   pixel_clk,sys_clk,tmds_clk; 
 assign pixel_clk=sys_clk; 
 DCM_PLL DCM_INST(  
  .clk_in1(clk), //CLK100M IN   
  .clk_out1(sys_clk),//CLK25M_OUT   
  .clk_out2(tmds_clk),//CLK250M_OUT   
  .locked(),  
  .reset(1'b0)  
 );  
 
 

//	CPU Clock
wire step_pulse;
 button_process_unit  step_pulse_inst(
   .clk(sys_clk),
   .reset(0),
   .ButtonIn(step),
   .ButtonOut(step_pulse)
   );
reg step_pulse_reg;
always @(posedge sys_clk) step_pulse_reg=step_pulse;  
 wire cpu_clk;
 assign cpu_clk=run_mode? sys_clk:step_pulse_reg;

 //CPU实例
    wire [31:0] PC;
    wire [31:0] ALU_A, ALU_B,ALUResult;
    wire [31:0] MemDout_mem;
    wire [31:0] Instruction_id;
  	wire[1:0]	JumpFlag;
    wire Stall;
Risc5CPU   CPUInst(
    .clk(cpu_clk), 
	.reset(reset), 
	.PC(PC), 
	.ALU_A(ALU_A), 
	.ALU_B(ALU_B), 
	.ALUResult_ex(ALUResult), 
	.MemDout_mem(MemDout_mem),  
	.JumpFlag(JumpFlag), 
	.Instruction_id(Instruction_id),
	.Stall(Stall));

	//同步发生器实�?
wire[9:0] PosX;
wire[8:0] PosY;
wire hSync,vSync,ActiveArea;
syncGenarator sync_inst(  
    .pixel_clk(pixel_clk), // 
    .reset(0), 
    .PosX(PosX) , 
    .PosY(PosY) , 
    .hSync(hSync) ,
    .vSync(vSync) , 
    .ActiveArea(ActiveArea));  

//	VgaData
	wire[7:0] red, green, blue;

 vga_data VgaData(
	.pixel_clk(sys_clk)			, // system clock, 25MHz
	.PC(PC[7:0])		, 
	.JumpFlag(JumpFlag)	,
	.ALU_A(ALU_A),
    .ALU_B(ALU_B),
    .ALUResult(ALUResult),
    .MemData(MemDout_mem),
    .Instruction(Instruction_id),
    .Stall(Stall),	
	.x_pos( PosX)		, // vga input x position
	.y_pos( PosY)		, // vga input y position
	// ================= output signals =================================
	.red(red),
	.green(green),
    .blue(blue));

//TMDS编码实例
wire TMDSch0,TMDSch1,TMDSch2;
 
 TMDSencode  TMDS_inst(  
    //时钟
	.tmds_clk(tmds_clk),  //  
    .pixel_clk(pixel_clk), 
	//复位信号，高电平有效
	.reset(0),
    //视频信号
    .red(red),
	.green(green),
	.blue(blue),
	.hSync(hSync),
	.vSync(vSync),
	.ActiveArea(ActiveArea),
	//TMDS通道输出数据
    .TMDSch0(TMDSch0),
	.TMDSch1(TMDSch1),
	.TMDSch2(TMDSch2)
); 
//HDMI 差分输出
OBUFDS OBUFDS_red  (.I(TMDSch2), .O(TMDSp[2]), .OB(TMDSn[2]));  
OBUFDS OBUFDS_green(.I(TMDSch1), .O(TMDSp[1]), .OB(TMDSn[1]));  
OBUFDS OBUFDS_blue (.I(TMDSch0), .O(TMDSp[0]), .OB(TMDSn[0]));  
OBUFDS OBUFDS_clk(.I(pixel_clk), .O(TMDSp_clk), .OB(TMDSn_clk));   

endmodule
