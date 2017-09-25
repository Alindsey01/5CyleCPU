`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:05:19 04/06/2017 
// Design Name: 
// Module Name:    MASTER_MEM 
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
module MASTER_MEM(EX_MEM, clk, MEM_WB);
     //main I/O
	  input [72:0] EX_MEM;
     input clk;
	  output reg [71:0] MEM_WB;
	  reg [31:0] mem_1k [0:1024];
     //internal connections

//put stuff in main mem
    initial begin
	 mem_1k[0] = 32'b0000_0000_0000_0000_0000_0000_0000_0001;
	 mem_1k[1] = 32'b0000_0000_0000_0000_0000_0000_0110_1101;
	 mem_1k[2] = 32'b0000_0000_0000_0000_0000_0000_0000_0011;
	 mem_1k[3] = 32'b0000_0000_0000_0000_0000_0000_0000_0101;
    end
  //declare the memory block
	 //intialize the output
	 initial begin
	 MEM_WB <= 0;
	 end
	 
	 always @(posedge clk)begin
	 
	 // clear reg if reset
	
	 
	 if(EX_MEM[38])
	 begin
	 //MEM_WB[68:37] <= mem_1k[EX_MEM[36:5]];
	 MEM_WB[68:37] <= mem_1k[EX_MEM[71:40]];
	 end
	 //this block writes to memory
	 if(EX_MEM[39])
	 begin
	 mem_1k[EX_MEM[71:40]] <= EX_MEM[36:5];
	 end
	 //passthrough source 2 from exmem
	 
	 
	 MEM_WB[70] <= EX_MEM[38]; //pass mem rd (drives a mux in next module in chain)
	 
	 MEM_WB[36:5] <= EX_MEM[36:5];  //pass data from ource 2 through , will be selected in next module
	 
	 MEM_WB[4:0] <= EX_MEM[4:0];  //pass dest_add
	 
	 MEM_WB[69] <= EX_MEM[37];  //pass write enable 
	
	 if(EX_MEM[72] == 1) begin
	 MEM_WB <= 0;
	 end
	 MEM_WB[71] <= EX_MEM[72];
	 end
endmodule
