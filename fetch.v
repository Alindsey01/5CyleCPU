`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:53:45 04/11/2017 
// Design Name: 
// Module Name:    fetch 
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
module fetch(clk,clr,instruct);
input clk;
input clr;
output reg [32:0] instruct;

reg [31:0] inst_mem [0:63];

initial begin
instruct <= 0;
end
// initialize instruction set to be executed

initial
begin

inst_mem[0] = {6'b000000, 5'b00001, 5'b00010, 16'b00011_00000_000000 }; //enable add
inst_mem[1] = {6'b000001, 5'b00001, 5'b00010, 16'b00100_00000_000000 }; //enable sub 
inst_mem[2] = {6'b000101, 5'b00001, 5'b00010, 16'b00110_00000_000000 }; //enable and
inst_mem[3] = {6'b000110, 5'b00001, 5'b00010, 16'b00101_00000_000000 }; //enable  or
inst_mem[4] = {6'b000111, 5'b00001, 5'b00010, 16'b00111_00000_000000 }; //enable xor
inst_mem[5] = {6'b000011, 5'b00001, 5'b00010, 16'b01000_00001_000000 }; //shift left
inst_mem[6] = {6'b000100, 5'b00001, 5'b00010, 16'b01001_00010_000000 }; //shiftright
inst_mem[7] = {6'b001011, 5'b00001, 5'b00010, 16'b00000_00000_000100 }; //addimmed  
inst_mem[8] = {6'b000010, 5'b00001, 5'b00010, 16'b00000_00000_000001 }; //load immed
inst_mem[9] = {6'b100011, 5'b00001, 5'b00010, 16'b01100_00000_000000 }; //load word 
inst_mem[10] = {6'b101011,5'b00001, 5'b00100, 16'b01101_00000_000000 }; //storeword 
inst_mem[11] = {6'b100011, 5'b00001, 5'b00010, 16'b01100_00000_000000 }; //load word 
inst_mem[12] = {6'b000000, 5'b00001, 5'b00010, 16'b00011_00000_000000 }; //enable add
inst_mem[13] = {6'b000001, 5'b00001, 5'b00010, 16'b00100_00000_000000 }; //enable sub 
inst_mem[14] = {6'b111111, 5'b00001, 5'b00010, 16'b00100_00000_000000 } ; //end command
end                                              

//declare the counter that will update pc every 5 cycles
reg [2:0] counter;
reg [31:0] pc;  // program counter
reg re; // read enable
initial begin
pc <= 0;
counter <= 0;
//re = 0;
end

always @(posedge clk) begin         //works with the posedge of the clock
counter <= counter + 1;             //iterate the counter
if(counter > 3)begin                // when counter eqquals 4 then true i.e. counts to 5
counter <= 0;                       //reset counter
instruct[31:0] <= inst_mem[pc];     // pass the instruction code to the output
pc <= pc + 1;                       //update the pc counter by pc + 1
end
instruct[32] <= 0;  //pass null if not reset
if(clr)begin                         //clear external register
instruct[32] <= 1;
instruct[31:0] <= 0;
pc <= 0;
counter <= 0;
end
 
end
endmodule
