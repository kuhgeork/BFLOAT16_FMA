`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2023 12:35:32 AM
// Design Name: 
// Module Name: program_counter
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


module program_counter(clk,reset,PC);
input clk;
input reset;
output reg [3:0] PC;

always @(posedge clk or posedge reset)
begin
if (reset) 
PC <= 4'b0000;
else
PC <= PC + 4'b0001;
end

endmodule
