`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSUF
// Engineer: Anthony Ruiz
// 
// Create Date: 11/09/2014 03:46:42 PM
// Module Name: temp
// Project Name: temp project 
// Description: manually inputs data using switches 15,14,13,12
//////////////////////////////////////////////////////////////////////////////////


module input_temp(
    input clk, //i dont think you need a clock since we are hard setting temperature using switches
	input [3:0] switches, //each one has a set etmperature to it 
	output reg [1:0]temp_out

	
	);

   always @ (switches)begin 
    case(switches)
        //binary ---------> decimal
        4'b0000: temp_out = 90;
        4'b1001: temp_out = 85;
        4'b0100: temp_out = 75;
        4'b0010: temp_out = 60;
        4'b0001: temp_out = 46;

        default: temp_out = 75; 
        
    endcase 
    end 


endmodule 
