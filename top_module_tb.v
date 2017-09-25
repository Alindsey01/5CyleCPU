`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:49:31 04/13/2017
// Design Name:   DECODER
// Module Name:   U:/cpu2/top_module_tb.v
// Project Name:  cpu2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DECODER
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_module_tb;

	// Inputs
	reg clk;
	reg clr;
	
	
	
   wire [32:0] instruct;
	wire [121:0] id_ex;
	wire [72:0] EX_MEM;
	wire [71:0] MEM_WB;
	wire [37:0] wb_FETCH;

	// Instantiate the Unit Under Test (UUT)
	 DECODER uut1(.wb_FETCH(wb_FETCH), .clk(clk), .instruct(instruct),  .id_ex(id_ex));
    fetch uut2(.clk(clk),.clr(clr),.instruct(instruct));
	 EXECUTE uut3(.EX_MEM(EX_MEM), .id_ex(id_ex), .clk(clk));
	 MASTER_MEM uut4(.EX_MEM(EX_MEM), .clk(clk),  .MEM_WB(MEM_WB));
	 WB_FETCH uut5(.MEM_WB(MEM_WB), .wb_FETCH(wb_FETCH), .clk(clk));
	 always #5 clk =~clk;
	initial begin
		// Initialize Inputs
	   
		clk = 0;
	



		// Wait 100 ns for global reset to finish
	//always @(posedge clk) begin	
        
		//
		if(instruct[31:26] == 6'b111111) $finish;
		
		
   end
	
      
endmodule

