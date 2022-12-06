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
    inout SDA,
    input BTNC,
    output SCL,
    output [6:0] sseg_out,
    output [7:0] an_out,
    output [2:0] rgb_out
    );
    
    wire clk_200kHz;
    wire [7:0] ReadTemp;
    wire [7:0] CurrentTemp;
    wire [7:0] ChangedTemp;
    wire [7:0] DesiredTemp;
    
    clkgen_200kHz clk_200kHz1(.clk_100MHz(clk), .clk_200kHz(clk_200kHz));
    i2c_master temp_get(.clk_200kHz(clk_200kHz), .reset(BTNC), .SDA(SDA), .temp_data(ReadTemp), .SDA_dir(SDA_dir), .SCL(SCL));
    Thermostat thermo(.Reset(Reset), .Set(Set), .Up(Up), .Down(Down), .clk(clk), .Temperature(ReadTemp), .CurrentTemp(CurrentTemp), .ChangedTemp(ChangedTemp),.DesiredTemp(DesiredTemp));
    RGB rgb(.clk(clk), .reset(Reset), .temp_set(Set), .desired_temp(DesiredTemp), .temp_in(CurrentTemp), .rgb_out(rgb_out));
    sseg_display sseg(.clk(clk), .CurrentTemp(CurrentTemp), .ChangedTemp(ChangedTemp), .sseg_out(sseg_out), .an_out(an_out));
    
endmodule