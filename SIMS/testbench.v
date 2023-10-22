`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.10.2023 23:39:51
// Design Name: 
// Module Name: testbench
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


module testbench;

reg [15:0] num1;
reg [15:0] num2;
wire [15:0] result;
wire zero,underflow,overflow,qNaN,sNaN,positive_inf,negative_inf;

//BF16_adder dut(num1,num2,result,zero,underflow,overflow,qNaN,sNaN,positive_inf,negative_inf);
//BF16_multiplier dut(num1,num2,result,zero,underflow,overflow,qNaN,sNaN,positive_inf,negative_inf);

initial
begin
#5 num1 = 16'hc20f; num2 = 16'h41a4;
#20 $finish;
end

endmodule
