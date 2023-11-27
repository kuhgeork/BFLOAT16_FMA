`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2023 12:36:56 AM
// Design Name: 
// Module Name: instr_mem
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


module instr_mem(PC_addr , data);
input [3:0] PC_addr;
output reg [49:0] data;

reg [49:0] reg_bank [0:15];


    

always @(PC_addr)
begin
    $readmemb ("inputs.mem",reg_bank);
    data <= reg_bank[PC_addr];
end

endmodule
