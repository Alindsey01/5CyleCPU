`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Texas State HDL Class
// Engineer: Alexander Lindsey, Jose Hernandez, Johnathen
// 
// Create Date:    17:13:46 04/20/2017 
// Design Name: 
// Module Name:    WB_FETCH 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: same as rev 3 but with clear function
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module WB_FETCH(
 input [71:0] MEM_WB,
 output reg [37:0] wb_FETCH,
 input clk,
 input clr
    );

always @(posedge clk) begin
   
	 
	 
    wb_FETCH[4:0] <= MEM_WB[4:0];
	 wb_FETCH[37] <= MEM_WB[69];
	
  	 if(MEM_WB[70]) begin
	 wb_FETCH[36:5] <= MEM_WB[68:37];
	 end
	 else begin
	 wb_FETCH[36:5] <= MEM_WB[36:5];
	 end
	 
	 if(MEM_WB[71] == 1) begin
	 wb_FETCH <= 0;
	 end
    end
endmodule
