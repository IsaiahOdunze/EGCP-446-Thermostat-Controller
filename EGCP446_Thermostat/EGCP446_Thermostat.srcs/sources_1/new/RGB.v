`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2022 09:08:14 PM
// Design Name: 
// Module Name: RGB
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


module RGB(
    input clk,
    input reset,
    input temp_set,
    input [7:0] desired_temp,
    input [7:0] temp_in,
    output [2:0] rgb_out
    );
    //wire sclk;
    reg temp_s;
    reg flag;
    reg [6:0] d_temp;
    reg [6:0] t_in;
    reg [2:0] rgb;
        
    always @(posedge clk or posedge reset) begin
        if(reset)
            rgb <= 3'b010;
        else 
        begin
            d_temp <= desired_temp;
            t_in <= temp_in;
            temp_s <= temp_set;           
             if(temp_s) begin
                flag <= 1'b1;
                if((d_temp > t_in) && temp_s) 
                    rgb <= 3'b100; 
                 else if((d_temp < t_in) && temp_s)
                rgb <= 3'b001; 
            else if((d_temp == t_in) && temp_s)
                rgb <= 3'b010;            
            end else begin
            if((temp_s == 0) && flag)
               if(d_temp > t_in)
                rgb <= 3'b100;
               else if(d_temp < t_in)
                rgb <= 3'b001;
               else if(d_temp == t_in)
                rgb <= 3'b010;
                flag <= 1'b0;             
       end 
       end        
       end     
       assign rgb_out = rgb;
endmodule