`timescale 1ns / 1ps
module top(
    input clk_in, rst, 
    //output [15:0] result,
    
    output zero,underflow,overflow,qNaN,sNaN,positive_inf,negative_inf,
    output [0:6] LED_out,
    output [3:0] Anode_Activate
    );
    
    
    wire [15:0] result;
    wire [3:0] PC_addr;
    wire [49:0] data;
    //wire en; // enable for C_reg
    reg [15:0] k,j;
   
    
    
    //wire [15:0] result;
    wire [15:0] A,B,C;
    //wire clk_out;
    //clk_divider c1(clk_in,clk_out);
    program_counter pc1 (clk_in,rst,PC_addr);
    BF16_FMA dut(A,B,C,result,zero,underflow,overflow,qNaN,sNaN,positive_inf,negative_inf);
        
    
    instr_mem inst1 (PC_addr, data);
  

            
    assign A = data[47:32];
    assign B = data[31:16];
    always @(PC_addr)
    begin
     if (data[49])
    //data[49] is enable
         k <= result;
         
      else
        j <= result;
    end
    
   assign C = data[48] ? data[15:0] : k;
    
    

    seg7_control seg(clk_in, rst,j, LED_out, Anode_Activate);
    
endmodule
