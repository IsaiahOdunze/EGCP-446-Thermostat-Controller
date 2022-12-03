`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Kenneth Ayala
// Create Date: 11/21/2022 11:49:55 PM
// Module Name: Thermostat
// Project Name: Thermostat Controller
// Description: This module has 5 inputs and 2 outputs. This module acts as the 
//              thermostat controller with Up/Down buttons to control the temperature
//              wanted and Set to start temperature change. And a Reset button 
//              to reset the temperature. Has two outputs one is the changed 
//              temperature that is changed with up/down and the other output 
//              is to simulate the current temperature changing once set.
// 
//////////////////////////////////////////////////////////////////////////////////


module Thermostat(
    input Reset,
    input Set,
    input Up,
    input Down,
    input clk,
    input [7:0] Temperature,//reading from temp sensor
    output [7:0] CurrentTemp,
    output [7:0] ChangedTemp    
    );
    reg [7:0] DesiredTmp;
    reg [7:0] Current;    
    reg [7:0] tmp;
    reg [7:0] tmp2;
    
   
    wire slowclock1;
    wire slowclock2;
    
    clock_divider1 CD1(.clk(clk),.reset(Reset),.sclk(slowclock1));
    clock_divider2 CD2(.clk(clk),.reset(Reset),.sclk(slowclock2));

    always @(posedge slowclock1 or posedge Reset)
    begin 
        if (Reset)
            tmp = tmp2;  //temp change is set back to zero or original temp
        else if (Up)            //if up button pressed temp will go up by 1
        begin 
            if (tmp == 8'b01100011)// stops from going over 99
            begin 
                tmp = 8'b01100011;//99 is max 
            end
            else
            tmp = tmp + 1'b1; // change the temp up one
        end
        else if (Down)          //if down button is pressed temp will go down by 1
        begin 
            if (tmp == 8'b00000000) //stops from going under 0
            begin 
                tmp = 8'b00000000;//0 is minimum
            end
            else
            tmp = tmp - 1'b1;   // change the temp down one
        end
        end 

        
        always @(posedge slowclock2)
        begin 
            if (Set) //if set pressed the desired temp will be assigned then 
                     //start to increment or decrement current temperature
            begin
                DesiredTmp = tmp;
            end
            
            else if (tmp2 < DesiredTmp)//if current is less than desired it will increase
                begin 
                tmp2 = tmp2 + 1'b1;
                end
            else if (tmp2 > DesiredTmp)//if current greater than desired it will decrease
                begin
                tmp2 = tmp2 - 1'b1;
                end
            else if (tmp2 == DesiredTmp)//if equal it will stay at that temperature
                begin
                tmp2 = tmp2;
                end
            else
             begin
             tmp2 = Temperature;        //these values are acting as the temp sensor value
             DesiredTmp = Temperature; 
             end
        end
            
        assign CurrentTemp = tmp2;
        assign  ChangedTemp = tmp;
    
endmodule
/////////////////////////////////////////////////////////////////////////////
/*
    Slow_Clock Module 
    Description: clock divider used for the thermostat up/down
*/
/////////////////////////////////////////////////////////////////////////////


module clock_divider1(

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
    if(count == 32'd10000000) begin 
    count <= 32'd0;
    sclk <= ~sclk;
        end else begin
    count <= count + 1;
        end
    end
    end
endmodule
/////////////////////////////////////////////////////////////////////////////
/*
    Clock_divider module for current temperature changing acting like 
    a airconditioning is heating or cooling room will go slower
*/
/////////////////////////////////////////////////////////////////////////////


module clock_divider2(

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
    if(count == 32'd80000000) begin 
    count <= 32'd0;
    sclk <= ~sclk;
        end else begin
    count <= count + 1;
        end
    end
    end
endmodule