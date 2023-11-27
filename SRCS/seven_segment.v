`timescale 1ns / 1ps

module seg7_control(
    input clock_100Mhz,
    input reset,
    input [15:0] result,
    output reg [0:6] LED_out,       // segment pattern 0-9
    output reg [3:0] Anode_Activate      // Anode_Activateselect signals
    );
    
    // Parameters for segment patterns
    parameter ZERO  = 7'b000_0001;  // 0
    parameter ONE   = 7'b100_1111;  // 1
    parameter TWO   = 7'b001_0010;  // 2 
    parameter THREE = 7'b000_0110;  // 3
    parameter FOUR  = 7'b100_1100;  // 4
    parameter FIVE  = 7'b010_0100;  // 5
    parameter SIX   = 7'b010_0000;  // 6
    parameter SEVEN = 7'b000_1111;  // 7
    parameter EIGHT = 7'b000_0000;  // 8
    parameter NINE  = 7'b000_0100;  // 9
    parameter A     = 7'b0001_000;  // A
    parameter B     = 7'b1100_000;  // B
    parameter C     = 7'b0110_001;  // C
    parameter D     = 7'b1000_010;  // D
    parameter E     = 7'b0110_000;  // E
    parameter F     = 7'b0111_000;  // F
    
    
    // To select each Anode_Activatein turn
    reg [1:0] digit_select;     // 2 bit counter for selecting each of 4 digits
    reg [16:0] digit_timer;     // counter for Anode_Activaterefresh
    
    // Logic for controlling Anode_Activateselect and Anode_Activatetimer
    always @(posedge clock_100Mhz or posedge reset) begin
        if(reset) begin
            digit_select <= 0;
            digit_timer <= 0; 
        end
        else                                        // 1ms x 4 displays = 4ms refresh period
            if(digit_timer == 99_999) begin         // The period of 100MHz clock is 10ns (1/100,000,000 seconds)
                digit_timer <= 0;                   // 10ns x 100,000 = 1ms
                digit_select <=  digit_select + 1;
            end
            else
                digit_timer <=  digit_timer + 1;
    end
    
    // Logic for driving the 4 bit anode output based on Anode_Activateselect
    always @(digit_select) begin
        case(digit_select) 
            2'b00 : Anode_Activate= 4'b1110;   // Turn on ones digit
            2'b01 : Anode_Activate= 4'b1101;   // Turn on tens digit
            2'b10 : Anode_Activate= 4'b1011;   // Turn on hundreds digit
            2'b11 : Anode_Activate= 4'b0111;   // Turn on thousands digit
        endcase
    end
    
    // Logic for driving segments based on which Anode_Activateis selected and the value of each digit
    always @*
        case(digit_select)
            2'b00 : begin       // ONES DIGIT
                        case(result[3:0])
                            4'b0000 : LED_out= ZERO;
                            4'b0001 : LED_out= ONE;
                            4'b0010 : LED_out= TWO;
                            4'b0011 : LED_out= THREE;
                            4'b0100 : LED_out= FOUR;
                            4'b0101 : LED_out= FIVE;
                            4'b0110 : LED_out= SIX;
                            4'b0111 : LED_out= SEVEN;
                            4'b1000 : LED_out= EIGHT;
                            4'b1001 : LED_out= NINE;
                            4'b1010 : LED_out= A;
                            4'b1011 : LED_out= B;
                            4'b1100 : LED_out= C;
                            4'b1101 : LED_out= D;
                            4'b1110 : LED_out= E;
                            4'b1111 : LED_out= F;
                            
                        endcase
                    end
                    
            2'b01 : begin       // TENS DIGIT
                        case(result[7:4])
                            4'b0000 : LED_out= ZERO;
                            4'b0001 : LED_out= ONE;
                            4'b0010 : LED_out= TWO;
                            4'b0011 : LED_out= THREE;
                            4'b0100 : LED_out= FOUR;
                            4'b0101 : LED_out= FIVE;
                            4'b0110 : LED_out= SIX;
                            4'b0111 : LED_out= SEVEN;
                            4'b1000 : LED_out= EIGHT;
                            4'b1001 : LED_out= NINE;
                            4'b1010 : LED_out= A;
                            4'b1011 : LED_out= B;
                            4'b1100 : LED_out= C;
                            4'b1101 : LED_out= D;
                            4'b1110 : LED_out= E;
                            4'b1111 : LED_out= F;
                        endcase
                    end
                    
            2'b10 : begin       // HUNDREDS DIGIT
                        case(result[11:8])
                            4'b0000 : LED_out= ZERO;
                            4'b0001 : LED_out= ONE;
                            4'b0010 : LED_out= TWO;
                            4'b0011 : LED_out= THREE;
                            4'b0100 : LED_out= FOUR;
                            4'b0101 : LED_out= FIVE;
                            4'b0110 : LED_out= SIX;
                            4'b0111 : LED_out= SEVEN;
                            4'b1000 : LED_out= EIGHT;
                            4'b1001 : LED_out= NINE;
                            4'b1010 : LED_out= A;
                            4'b1011 : LED_out= B;
                            4'b1100 : LED_out= C;
                            4'b1101 : LED_out= D;
                            4'b1110 : LED_out= E;
                            4'b1111 : LED_out= F;
                        endcase
                    end
                    
            2'b11 : begin       // MINUTES ONES DIGIT
                        case(result[15:12])
                            4'b0000 : LED_out= ZERO;
                            4'b0001 : LED_out= ONE;
                            4'b0010 : LED_out= TWO;
                            4'b0011 : LED_out= THREE;
                            4'b0100 : LED_out= FOUR;
                            4'b0101 : LED_out= FIVE;
                            4'b0110 : LED_out= SIX;
                            4'b0111 : LED_out= SEVEN;
                            4'b1000 : LED_out= EIGHT;
                            4'b1001 : LED_out= NINE;
                            4'b1010 : LED_out= A;
                            4'b1011 : LED_out= B;
                            4'b1100 : LED_out= C;
                            4'b1101 : LED_out= D;
                            4'b1110 : LED_out= E;
                            4'b1111 : LED_out= F;
                        endcase
                    end
        endcase

endmodule