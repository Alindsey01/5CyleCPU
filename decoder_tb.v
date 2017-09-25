`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:01:52 04/22/2017
// Design Name:   DECODER
// Module Name:   C:/Users/ADMIN/Desktop/Code/Verilog/cpu3/decoder_tb.v
// Project Name:  cpu3
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

module decoder_tb;

	// Inputs
	reg [37:0] wb_FETCH;
	reg clk;
	reg [31:0] instruct;
	reg clr;

	// Outputs
	wire [120:0] id_ex;

	// Instantiate the Unit Under Test (UUT)
	DECODER uut (
		.wb_FETCH(wb_FETCH), 
		.clk(clk), 
		.instruct(instruct), 
		.clr(clr), 
		.id_ex(id_ex)
	);
 always #5 clk =~clk;
	initial begin
		// Initialize Inputs
		wb_FETCH = 0;
		clk = 0;
		instruct = 0;
		clr = 0;

 #10 wb_FETCH = 38'b10_0000_1000_0000_0000_0000_0000_1001_1000_0001;
 #10 wb_FETCH = 38'b10_0000_1000_0000_0000_0000_0000_1111_1000_0010;
 #10 wb_FETCH = 38'b10_0000_1000_0000_0000_0000_0000_1001_1011_0011;
 #10 wb_FETCH = 38'b10_0000_1000_0000_0000_0000_0011_1001_1000_0100;
 #10 wb_FETCH = 38'b10_0000_1000_0000_0000_1111_0000_1001_1000_0101;

		// Wait 100 ns for global reset to finish
		#1000;
        
		  $finish;
		// Add stimulus here

	end
      
endmodule

