`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Connor Bartholomew
// Create Date: 12/2/2022 7:35:55 PM
// Module Name: sseg_display
// Project Name: EGCP446_Thermostat
// Description: This module has 3 inputs and 2 outputs. It takes in a current temperature
//              and a changed temperature and displays them across the separate anodes of
//              the seven segment display.
//
//////////////////////////////////////////////////////////////////////////////////

module sseg_display(
    input clk,
    input [7:0] CurrentTemp,
    input [7:0] ChangedTemp,
    output reg [6:0] sseg_out, //Segment of the seven segment display
    output reg [7:0] an_out //Anodes of the seven segment display
    );
    
    wire [3:0] current_tens, current_ones;
    assign current_tens = CurrentTemp / 10;           //Retrieves tens place of CurrentTemp
    assign current_ones = CurrentTemp % 10;           //Retrieves ones place of CurrentTemp
    
    wire [3:0] changed_tens, changed_ones;
    assign changed_tens = ChangedTemp / 10;           //Retrieves tens place of ChangedTemp
    assign changed_ones = ChangedTemp % 10;           //Retreieves ones place of ChangedTemp
    
    //Parameters for seven segment outputs
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
    parameter DEG   = 7'b0011100;  // degrees
    parameter F     = 7'b0111000;  // Farenheit
    
    reg [2:0] an_sel;   // 3 bit counter for selecting which anode to display to
    reg [16:0] counter; // Counter for clock divider to refresh anodes
    
    //Clock Divider to handle refresh of anodes
    always @(posedge clk) begin
        if(counter == 49999) 
        begin
            counter <= 0;
            an_sel <=  an_sel + 1;
        end
        else
            counter <=  counter + 1;
    end
    
    //Case statement to select which anode to display to based on an_sel from clock divider
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
            3'b000 : sseg_out = F;    // Set to F for Farenheit
                        
            3'b001 : sseg_out = DEG;  // Set to degrees
                    
            3'b010 : begin
                        case(current_ones) //CurrentTemp ones digit to display
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
                    
            3'b011 : begin
                        case(current_tens) //CurrentTemp tens digit to display
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
                    
            3'b100 : sseg_out = F;
                        
            3'b101 : sseg_out = DEG;
            
            3'b110 : begin
                        case(changed_ones) //ChangedTemp ones digit to display
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
                        case(changed_tens) //ChangedTemp tens digit to display
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