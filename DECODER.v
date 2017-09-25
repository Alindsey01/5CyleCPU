`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:06:50 03/30/2017 
// Design Name: 
// Module Name:    DECODER 
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
module DECODER(wb_FETCH,clk,instruct, id_ex);
// mux variable
	  input clk;
	  input [37:0] wb_FETCH; //brings in a word that writes back to the rf data reg

  //put values in register for use in program
initial
   begin
	data_rf[0] = 32'h00000000;
	data_rf[1] = 32'h00000002;
	data_rf[2] = 32'h00000001;
	data_rf[3] = 32'h00000005;
	data_rf[4] = 32'h00001111;
	data_rf[5] = 32'h00000011;
	data_rf[6] = 32'h22222222;
	data_rf[7] = 32'h33333333;
	data_rf[8] = 32'h44444444;	
   end
	
//chop up instructions
	  input[32:0] instruct;
	  output reg [121:0] id_ex;
     wire [5:0] opcd    = instruct[31:26];     //operation code
	  wire [4:0] rs      = instruct[25:21];     //rs register address
	  wire [4:0] rt      = instruct[20:16];     // rt register address
	  wire [15:0] imm    = instruct[15:0];      //immediate variable
	  wire [4:0] imm2    = instruct[15:11];     // this can be rd when needed by instruction type R

	//Declare the data_rf register
	 reg [31:0] data_rf [0:31];
	 
	 //decoder   do everything at positive edge of the clock
	 always @(posedge clk) begin
	
	 // fetch data at address if not $0 reg
		 id_ex[51:20] = (rs == 0)? 0 : data_rf[rs];    
		 id_ex[83:52] = (rt == 0)? 0 : data_rf[rt];

	 
	 //opcode cases
	     case(instruct[31:26])
	         6'b000000: begin
							  id_ex[19:0] <= 16'h0001;  // enable add 0000 0000 0000 0001
							  id_ex[120:116] <= imm2;   //pass address
							  end
				6'b000001: begin
				           id_ex[19:0] <= 16'h0002;  // enable sub 0000 0000 0000 0010
						     id_ex[120:116] <= imm2;   //pass address R type
							  end
				6'b000101: begin
				           id_ex[19:0] <= 16'h0004;  // enable and 0000 0000 0000 0100
				           id_ex[120:116] <= imm2;   //pass address R type
							  end
				6'b000110: begin
				           id_ex[19:0] <= 16'h0008;  // enable  or 0000 0000 0000 1000
				           id_ex[120:116] <= imm2;   //pass address R type
							  end
				6'b000111: begin
				           id_ex[19:0] <= 16'h0010;  // enable xor 0000 0000 0001 0000
				           id_ex[120:116] <= imm2;   //pass address R type
							  end
			   6'b000011: begin
				           id_ex[19:0] <= 16'h0020;  // shift left 0000 0000 0010 0000
				           id_ex[120:116] <= imm2;   //pass address R type
							  end
			   6'b000100: begin
				           id_ex[19:0] <= 16'h0040;  // shiftright 0000 0000 0100 0000
				           id_ex[120:116] <= imm2;   //pass address R type
							  end
			   6'b001011: begin
				           id_ex[19:0] <= 16'h0080;  // addimmed   0000 0000 1000 0000
				           id_ex[120:116] <= rt;     //pass address I type
							  end
				6'b000010: begin
				           id_ex[19:0] <= 16'h0100;  // load immed  0000 0001 0000 0000
				           id_ex[120:116] <= rt;	 
                       end							     //pass address I type
				6'b100011: begin
				           id_ex[19:0] <= 16'h0200;  // load word  0000 0010 0000 0000
				           id_ex[120:116] <= rt;	    //pass address R type
							  end
				6'b101011: begin
				           id_ex[19:0] <= 16'h0400;  // storeword  0000 0100 0000 0000
				           id_ex[120:116] <= 0;      //pass null address R type 
							  end
			endcase
			
			//write to data rf
		 if(wb_FETCH[37]==1'b1 )begin
				data_rf[wb_FETCH[4:0]] <= wb_FETCH[36:5];
				end
				
		// sign extend the immediate value to 32 bits making MSB 16 bit zeros
	     id_ex[115:100] <=0;
        id_ex[99:84] <= imm[15:0]; 
     
		if(instruct[32] == 1)begin
		id_ex = 0; 
		end
		id_ex[121] <= instruct[32];
	 end
		
endmodule