`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2023 15:48:54
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

reg clk, rst;
wire [15:0] res;
wire zero,underflow,overflow,qNaN,sNaN,positive_inf,negative_inf;
//wire [0:6] LED_out;
//wire [3:0] Anode_Activate;

top dut(clk,rst,res,zero,underflow,overflow,qNaN,sNaN,positive_inf,negative_inf,,);

initial
clk = 1'b0;
always #20 clk = ~clk;


initial
begin
#5 rst = 1'b1;
#8 rst = 1'b0;
#100 $finish;
end

endmodule
