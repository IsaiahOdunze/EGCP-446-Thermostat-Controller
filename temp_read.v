`timescale 1ns / 1ps
/*
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Anthony Ruiz
// Create Date: 11/29/2022 10:29:36 AM 
// Module Name: temp_read
// Project Name: term project temp_read module 
// Target Devices: nexys 4ddr 
 
// Description: 
            this module takes in 4 inputs and has one output 
            the output is the tempeture reading in ferenheit as "temp_out"
            temp_out is a bus sinc it is an intiger of decimal radix
*/
////////////////////////////////////////////////////////////////////////////////

/* ///////////////////////////////////////////////////////////////////////////////
                             temperature read module
/////////////////////////////////////////////////////////////////////////////// */
module temp_read(
    input clk,
    input reset,
    input [12:0] temp_in,
    output [12:0] temp_out // Data width is 13 for the ADT7420 Temperature Sensor
    );
    //more infor on the temp sensor 
   // https://users.wpi.edu/~rjduck/Temp%20Sensor%20Data%20Sheets.pdf
   // https://stackoverflow.com/questions/36946405/adt7420-temperature-reading-verilog
   
    wire slowclock;
    
    assign temp_out = 1.8*(temp_in - 273) + 32; //converts from kelvin to fahrenheit
    
    
    clock_divider clkDiv1(.clk(clk),.reset(reset),.sclk(slowclock));
    temp_read tr1 (.clk(slowkclock),.reset(reset),.temp_in(temp_in),.temp_out(temp_out));
    
    
    
endmodule

/* ///////////////////////////////////////////////////////////////////////////////
                       clock divider/slow clock module
/////////////////////////////////////////////////////////////////////////////// */

module clock_divider(
 
input clk,
input reset,
output reg sclk
);

reg [31:0] count;
    always@(posedge clk or posedge reset)
        begin
    if(reset == 1'b1) begin
    count <= 32'd0;
    sclk <= 1'b0;
        end else begin
    if(count == 32'd60000000) begin 
    count <= 32'd0;
    sclk <= ~sclk;
        end else begin
    count <= count + 1;
        end
    end
    end
    endmodule
