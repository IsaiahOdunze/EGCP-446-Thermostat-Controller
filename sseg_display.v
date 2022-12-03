`timescale 1ns / 1ps
// Created by David J. Marion
// Date 7.19.2022
// 7 Segment Control for the Nexys A7 Temperature Sensor

module sseg_display(
    input clk,               // Nexys A7 clock
    input [7:0] CurrentTemp,          // Temp data from i2c master
    input [7:0] ChangedTemp,
    output reg [6:0] sseg_out,           // 7 Segments of Displays
    output reg [7:0] an_out             // 4 Anodes of 8 to display Temp
    );
    
    wire [3:0] current_tens, current_ones;
    assign current_tens = CurrentTemp / 10;           // Tens value of temp data
    assign current_ones = CurrentTemp % 10;           // Ones value of temp data
    
    wire [3:0] changed_tens, changed_ones;
    assign changed_tens = ChangedTemp / 10;           // Tens value of temp data
    assign changed_ones = ChangedTemp % 10;           // Ones value of temp data
    
    // Parameters for segment patterns
    parameter ZERO  = 7'b0000001;  // 0
    parameter ONE   = 7'b1001111;  // 1
    parameter TWO   = 7'b0010010;  // 2 
    parameter THREE = 7'b0000110;  // 3
    parameter FOUR  = 7'b1001100;  // 4
    parameter FIVE  = 7'b0100100;  // 5
    parameter SIX   = 7'b0100000;  // 6
    parameter SEVEN = 7'b0001111;  // 7
    parameter EIGHT = 7'b0000000;  // 8
    parameter NINE  = 7'b0000100;  // 9
    parameter DEG   = 7'b0011100;  // degrees symbol
    parameter C     = 7'b0110001;  // 
    
        // To select each digit in turn
    reg [2:0] an_sel;         // 3 bit counter for selecting each of 8 digits
    reg [16:0] counter;         // counter for digit refresh
    
        // Logic for controlling digit select and digit timer
    always @(posedge clk) begin
        // 1ms x 8 displays = 8ms refresh period
        if(counter == 49999) begin         // The period of 100MHz clock is 10ns (1/100,000,000 seconds)
            counter <= 0;                   // 10ns x 100,000 = 1ms
            an_sel <=  an_sel + 1;
        end
        else
            counter <=  counter + 1;
    end
    
        // Logic for driving the 4 bit anode output based on digit select
    always @(an_sel) begin
        case(an_sel) 
            3'b000 : an_out = 8'b11111110;   // Turn on ones place of first set
            3'b001 : an_out = 8'b11111101;   // Turn on tens place of first set
            3'b010 : an_out = 8'b11111011;   // Turn on hundreds place of first set
            3'b011 : an_out = 8'b11110111;   // Turn on thousands place of first set
            3'b100 : an_out = 8'b11101111;   // Turn on ones place of second set
            3'b101 : an_out = 8'b11011111;   // Turn on tens place of second set
            3'b110 : an_out = 8'b10111111;   // Turn on hundreds place of second set
            3'b111 : an_out = 8'b01111111;   // Turn on thousands place of second set
        endcase
    end
    
        always @*
        case(an_sel)
            3'b000 : sseg_out = C;    // Set to C for Celsuis
                        
            3'b001 : sseg_out = DEG;  // Set to degrees symbol
                    
            3'b010 : begin       // TEMPERATURE ONES DIGIT
                        case(current_ones)
                            4'b0000 : sseg_out = ZERO;
                            4'b0001 : sseg_out = ONE;
                            4'b0010 : sseg_out = TWO;
                            4'b0011 : sseg_out = THREE;
                            4'b0100 : sseg_out = FOUR;
                            4'b0101 : sseg_out = FIVE;
                            4'b0110 : sseg_out = SIX;
                            4'b0111 : sseg_out = SEVEN;
                            4'b1000 : sseg_out = EIGHT;
                            4'b1001 : sseg_out = NINE;
                        endcase
                    end
                    
            3'b011 : begin       // TEMPERATURE TENS DIGIT
                        case(current_tens)
                            4'b0000 : sseg_out = ZERO;
                            4'b0001 : sseg_out = ONE;
                            4'b0010 : sseg_out = TWO;
                            4'b0011 : sseg_out = THREE;
                            4'b0100 : sseg_out = FOUR;
                            4'b0101 : sseg_out = FIVE;
                            4'b0110 : sseg_out = SIX;
                            4'b0111 : sseg_out = SEVEN;
                            4'b1000 : sseg_out = EIGHT;
                            4'b1001 : sseg_out = NINE;
                        endcase
                    end
                    
            3'b100 : sseg_out = C;    // Set to C for Celsuis
                        
            3'b101 : sseg_out = DEG;  // Set to degrees symbol
            
            3'b110 : begin
                        case(changed_ones)
                            4'b0000 : sseg_out = ZERO;
                            4'b0001 : sseg_out = ONE;
                            4'b0010 : sseg_out = TWO;
                            4'b0011 : sseg_out = THREE;
                            4'b0100 : sseg_out = FOUR;
                            4'b0101 : sseg_out = FIVE;
                            4'b0110 : sseg_out = SIX;
                            4'b0111 : sseg_out = SEVEN;
                            4'b1000 : sseg_out = EIGHT;
                            4'b1001 : sseg_out = NINE;
                        endcase
                    end
            3'b111 : begin
                        case(changed_tens)
                            4'b0000 : sseg_out = ZERO;
                            4'b0001 : sseg_out = ONE;
                            4'b0010 : sseg_out = TWO;
                            4'b0011 : sseg_out = THREE;
                            4'b0100 : sseg_out = FOUR;
                            4'b0101 : sseg_out = FIVE;
                            4'b0110 : sseg_out = SIX;
                            4'b0111 : sseg_out = SEVEN;
                            4'b1000 : sseg_out = EIGHT;
                            4'b1001 : sseg_out = NINE;
                        endcase
                    end
        endcase
    
endmodule