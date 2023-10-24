`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2023 19:50:16
// Design Name: 
// Module Name: BF16_FMA
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

//implement A*B + C where A,B,C are bfloat16 numbers given in hex notation
module BF16_FMA(A,B,C,result,zero,underflow,overflow,qNaN,sNaN,positive_inf,negative_inf);
input [15:0] A,B,C;
output [15:0] result;
output zero,underflow,overflow,qNaN,sNaN,positive_inf,negative_inf;
wire [15:0] intd_result;
BF16_multiplier M1(A,B,intd_result,,underflow1,overflow1,,,,);
BF16_adder A1(intd_result,C,result,zero,underflow2,overflow2,qNaN,sNaN,positive_inf,negative_inf);
assign overflow = (overflow1 == 1'b1 || overflow2 == 1'b1) ? 1'b1 : 1'bx;
assign underflow = (underflow1 == 1'b1 || underflow2 == 1'b1) ? 1'b1 : 1'bx;
endmodule
