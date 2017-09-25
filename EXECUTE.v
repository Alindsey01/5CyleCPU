`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:58:56 03/30/2017 
// Design Name: 
// Module Name:    EXECUTE 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
/*
we need to figure out the mux on the decode side and the mux that is post alu
that should select between alu_out and the shift
*/

module EXECUTE(EX_MEM, id_ex, clk);
	input [121:0] id_ex;
	 input clk;
	 output reg [72:0]EX_MEM;
	 wire [31:0] source1;       //result pulled from rs
	 wire [31:0] source2;       //result pulled from rt
	 wire [4:0] shamt;          //part of immediate word from previous block, R type op
	 wire [31:0] sext_imm;      // sign extended immediate
	 
	 assign source1 = id_ex[51:20];     //
	 assign source2 = id_ex[83:52];
	 assign sext_imm = id_ex[115:84];
	 assign shamt = id_ex[93:89];
    
	 initial begin
	 EX_MEM <= 0;
	 end
	
//begin at positive edge of the clock
    always @(posedge clk) begin
	 
	  //pass the address along
       EX_MEM[4:0] <= id_ex[120:116];
    
	 
	 
	 
// use counting trick to only pass write to data_rf with data 1 time per 5 cycles
/* 
 if(id_ex[10] == 0) begin
	EX_MEM[37] <=1;
	//count <=0;
	end
	if(id_ex[10] == 1) begin
	EX_MEM[37] <=0;
	//count <=0;
	end
*/

	
//ALU part
	if( id_ex[0])
	 begin
	    EX_MEM[36:5] <= source1 + source2;
		 EX_MEM[38]<=0;
		 EX_MEM[39]<=0;
		 EX_MEM[37]<=1;
		
	 end
	 if( id_ex[1])
	 begin
	    EX_MEM[36:5] <= source1 - source2;
		 EX_MEM[38]<=0;
		 EX_MEM[39]<=0;
		 EX_MEM[37]<=1;
	//	 suben <= 0;
		// $display("suben = %b", suben);
	 end
	 if( id_ex[2])
	 begin
	    EX_MEM[36:5] <= source1 & source2;
		EX_MEM[38]<=0;
		 EX_MEM[39]<=0;
		 EX_MEM[37]<=1;
		// anden <= 0;
		// $display("anden = %b", anden);
	 end
	 if(id_ex[3])
	 begin
	    EX_MEM[36:5] <= source1 | source2;
		EX_MEM[38]<=0;
		 EX_MEM[39]<=0;
		 EX_MEM[37]<=1;
	//	 oren <= 0;
	//	 $display("oren = %b", oren);
	 end
	 //xor
	 if( id_ex[4])
	 begin
	    EX_MEM[36:5] <= source1 ^ source2;
		 EX_MEM[38]<=0;
		 EX_MEM[39]<=0;
		 EX_MEM[37]<=1;
	//shift left
	 end
	if(id_ex[5])
	 begin
	    EX_MEM[36:5] <= source2 << shamt;
		 EX_MEM[38]<=0;
		 EX_MEM[39]<=0;
		EX_MEM[37]<=1;
	//shift right
	 end
	 if(id_ex[6])
	 begin
	    EX_MEM[36:5] <= source2 >> shamt;
		 EX_MEM[38]<=0;
		 EX_MEM[39]<=0;
		 EX_MEM[37]<=1;
	 end
	//add immediate
	if(id_ex[7])
	 begin
	    EX_MEM[36:5] <= source1 + sext_imm;
		 EX_MEM[38]<=0;
		 EX_MEM[39]<=0;
		 EX_MEM[37]<=1;
	 end
	 //load immediate which 
	if(id_ex[8])
	 begin 
		EX_MEM[36:5] <= sext_imm;
		EX_MEM[38]<=0;
		 EX_MEM[39]<=0;
		 EX_MEM[37]<=1;
	//	EX_MEM[37] = 1;
	 end
	 //load word
	if(id_ex[9])
	 begin
	   EX_MEM[38] <= 1;
		EX_MEM[71:40] <= source1;  
		EX_MEM[37]<=1;
		//{ sext_imm[15:0], source1};
	 end
	// store word
	if(id_ex[10])
	 begin
	   EX_MEM[39] <= 1;
		EX_MEM[38] <= 0;
		EX_MEM[37] <= 0;
		EX_MEM[36:5] <= source2;//data
		EX_MEM[71:40] <= source1;//address
	 end
    
	 if(id_ex[121] == 1) begin
	 EX_MEM <= 0;
    end
	 EX_MEM[72] <= id_ex[121];
end
endmodule
