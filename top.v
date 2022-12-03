`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2022 08:27:04 PM
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input Reset,
    input Set,
    input Up,
    input Down,
    output [6:0] sseg_out,
    output [7:0] an_out
    );
    
    wire [7:0] CurrentTemp;
    wire [7:0] ChangedTemp;
    
    Thermostat thermo(.Reset(Reset), .Set(Set), .Up(Up), .Down(Down), .clk(clk), .CurrentTemp(CurrentTemp), .ChangedTemp(ChangedTemp));
    sseg_display sseg(.clk(clk), .CurrentTemp(CurrentTemp), .ChangedTemp(ChangedTemp), .sseg_out(sseg_out), .an_out(an_out));
    
endmodule
