`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: sambit pal
// 
// Create Date: 10.10.2023 21:04:39
// Design Name: 
// Module Name: BF16_adder
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


module BF16_adder(num1,num2,result,zero,underflow,overflow,qNaN,sNaN,positive_inf,negative_inf);
input [15:0] num1;
input [15:0] num2;
output reg zero,underflow,overflow,qNaN,sNaN,positive_inf,negative_inf;
output reg [15:0] result;
reg res_sign;
reg signed [8:0] res_exp;
reg signed [8:0] res_mant;
reg [3:0] n;
wire sign1,sign2;
wire [7:0] exp1,exp2;
wire [6:0] mant1,mant2;
wire [7:0] mant_eff1,mant_eff2;

// assign the sign ,exp bits and mantissa bits
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
if (exp1 == 8'd0)
result = num2;
if (exp2 == 8'd0)
result = num1;
if (exp1 == 8'd0 && exp2 == 8'd0)
begin
result = 16'd0;
zero = 1'b1;
end
if ((exp1 == 8'hff && sign1 == 1'b0) || (exp2 == 8'hff && sign2 == 1'b0))
begin
result = 16'h7f80;
positive_inf = 1'b1;
end
else if ((exp1 == 8'hff && sign1 == 1'b1) || (exp2 == 8'hff && sign2 == 1'b1))
begin
result = 16'hff80;
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

if (sign1 ^ sign2 == 1'b0 && exp1 != 8'd0 && exp2 != 8'd0 && exp1 != 8'd255 && exp2 != 8'd255)
begin
if (exp1 >= exp2)
begin
res_sign = sign1 & sign2;
res_exp = exp1;
res_mant = mant_eff1 + mant_eff2 / (2** (exp1 - exp2));
end
else 
begin
res_sign = sign1 & sign2;
res_exp = exp2;
res_mant = mant_eff2 + mant_eff1 / (2**  (exp2 - exp1));
end
if (res_mant[8] == 1'b1)
begin
res_exp = res_exp + 9'd1;
res_mant = res_mant >> 1;

end

end

else if (sign1 ^ sign2 == 1'b1 && exp1 != 8'd0 && exp2 != 8'd0 && exp1 != 8'd255 && exp2 != 8'd255)
begin
if (exp1 > exp2)
begin
if (sign1 == 1'b1 & sign2 == 1'b0)
res_sign = 1'b1;
else if (sign1 == 1'b0 & sign2 == 1'b1)
res_sign = 1'b0;

res_exp = exp1;
res_mant = mant_eff1 - mant_eff2 / (2** (exp1 - exp2));



end
else if (exp1 < exp2)
begin
if (sign1 == 1'b1 & sign2 == 1'b0)
res_sign = 1'b0;
else if (sign1 == 1'b0 & sign2 == 1'b1)
res_sign = 1'b1;

res_exp = exp2;
res_mant = mant_eff2 - mant_eff1 /(2** (exp2 - exp1));

end
else if (exp1 == exp2)
begin
if (mant_eff1 >= mant_eff2 )
begin
if (sign1 == 1'b1 & sign2 == 1'b0)
res_sign = 1'b1;
else if (sign1 == 1'b0 & sign2 == 1'b1)
res_sign = 1'b0;

res_exp = exp1;
res_mant = mant_eff1 - mant_eff2;
end
else
begin
if (sign1 == 1'b1 & sign2 == 1'b0)
res_sign = 1'b0;
else if (sign1 == 1'b0 & sign2 == 1'b1)
res_sign = 1'b1;

res_exp = exp1;
res_mant = mant_eff2 - mant_eff1;
end


end
 

casez (res_mant)
9'b01zzzzzzz : n = 4'd0;
9'b001zzzzzz : n = 4'd1;
9'b0001zzzzz : n = 4'd2;
9'b00001zzzz : n = 4'd3;
9'b000001zzz : n = 4'd4;
9'b0000001zz : n = 4'd5;
9'b00000001z : n = 4'd6;
9'b000000001 : n = 4'd7;
9'b000000000 : n = 4'd8;
endcase

res_mant = res_mant* (2**n);
res_exp = res_exp - n ;

end
if (exp1 != 8'd0 && exp2 != 8'd0 && exp1 != 8'd255 && exp2 != 8'd255)
result = {res_sign,res_exp[7:0],res_mant[6:0]};
if (res_exp >= 9'd255)
overflow = 1'b1;
else if(res_exp[8] == 1'b1)
underflow = 1'b1;



end

endmodule