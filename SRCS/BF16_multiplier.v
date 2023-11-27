`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.10.2023 10:56:38
// Design Name: 
// Module Name: BF16_multiplier
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


module BF16_multiplier(num1,num2,result,zero,underflow,overflow,qNaN,sNaN,positive_inf,negative_inf);
input [15:0] num1;
input [15:0] num2;
output reg zero,underflow,overflow,qNaN,sNaN,positive_inf,negative_inf;
output reg [15:0] result;
reg res_sign;
reg signed [8:0] res_exp;
reg signed [15:0] res_mant;
wire sign1,sign2;
wire [7:0] exp1,exp2;
wire [6:0] mant1,mant2;
wire [7:0] mant_eff1,mant_eff2;

assign sign1 = num1[15];
assign sign2 = num2[15];
assign exp1 = num1[14:7];
assign exp2 = num2[14:7];
assign mant1 = num1[6:0]; 
assign mant2 = num2[6:0];
assign mant_eff1 = {1'b1,num1[6:0]};
assign mant_eff2 = {1'b1,num2[6:0]};

always @(*)
begin
if (exp1 == 8'd0 || exp2 == 8'd0)
begin
result = 16'd0;
zero = 1'b1;
end

if (exp1 == 8'hff && exp2 == 8'hff)
begin
result = {sign1 ^ sign2 , 15'b111111110000000};
if (sign1 ^ sign2 == 1'b0)
positive_inf = 1'b1;
else if (sign1 ^ sign2 == 1'b1)
negative_inf = 1'b1;
end

if (num1 == 16'h7fc1 || num2 == 16'hffc1)
begin
result = 16'hffc1;
qNaN = 1'b1;
end
else if (num1 == 16'h7f81 || num2 == 16'hff81)
begin
result = 16'hff81;
sNaN = 1'b1;
end

if (exp1 != 8'd0 && exp2 != 8'd0 && exp1 != 8'd255 && exp2 != 8'd255)
begin
res_sign = sign1 ^ sign2;
res_exp = exp1 + exp2 - 9'd127;
res_mant = mant_eff1 * mant_eff2;


if (res_mant[15] == 1'b1)
begin
res_exp = res_exp + 9'd1;
res_mant = res_mant >> 1;
end

result = {res_sign,res_exp[7:0],res_mant[13:7]};
if (res_exp >= 9'd255)
overflow = 1'b1;
else if(res_exp[8] == 1'b1)
underflow = 1'b1;

end
end
endmodule
