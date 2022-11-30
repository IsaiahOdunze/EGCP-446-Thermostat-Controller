`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2022 01:05:08 AM
// Design Name: 
// Module Name: decimal_to_binary
// Description: This module has 2 inputs and 1 output. It is used to convert 
//              the input HEX value from the thermostat module to convert 
//              to a decimal number that can be read by a seven segment display      
// 
//////////////////////////////////////////////////////////////////////////////////


module decimal_to_binary(
    input [7:0] Dtemp,
    input clk,
    output [7:0] Btemp
    
    );
    
    reg [7:0] firstsecond;
    reg [7:0] firstsecond1;
    
 always @(Dtemp) 

    begin 
     firstsecond = Dtemp[7:0];
    end
    
    always @(*)
     case(firstsecond)
        8'b00000000 :firstsecond1 = 8'b00000000;//0
        8'b00000001 :firstsecond1 = 8'b00000001;//1
        8'b00000010 :firstsecond1 = 8'b00000010;//2
        8'b00000011 :firstsecond1 = 8'b00000011;
        8'b00000100 :firstsecond1 = 8'b00000100;
        8'b00000101 :firstsecond1 = 8'b00000101;
        8'b00000110 :firstsecond1 = 8'b00000110;
        8'b00000111 :firstsecond1 = 8'b00000111;//7
        8'b00001000 :firstsecond1 = 8'b00001000;
        8'b00001001 :firstsecond1 = 8'b00001001;//9
        8'b00001010 :firstsecond1 = 8'b00010000;//10
        8'b00001011 :firstsecond1 = 8'b00010001;//11
        8'b00001100 :firstsecond1 = 8'b00010010;//12
        8'b00001101 :firstsecond1 = 8'b00010011;//13
        8'b00001110 :firstsecond1 = 8'b00010100;//14
        8'b00001111 :firstsecond1 = 8'b00010101;//15
        8'b00010000 :firstsecond1 = 8'b00010110;
        8'b00010001 :firstsecond1 = 8'b00010111;
        8'b00010010 :firstsecond1 = 8'b00011000;
        8'b00010011 :firstsecond1 = 8'b00011001;
        8'b00010100 :firstsecond1 = 8'b00100000;//20
        8'b00010101 :firstsecond1 = 8'b00100001;//21
        8'b00010110 :firstsecond1 = 8'b00100010;
        8'b00010111 :firstsecond1 = 8'b00100011;
        8'b00011000 :firstsecond1 = 8'b00100100;
        8'b00011001 :firstsecond1 = 8'b00100101;//25
        8'b00011010 :firstsecond1 = 8'b00100110;
        8'b00011011 :firstsecond1 = 8'b00100111;
        8'b00011100 :firstsecond1 = 8'b00101000;
        8'b00011101 :firstsecond1 = 8'b00101001;//29
        8'b00011110 :firstsecond1 = 8'b00110000;
        8'b00011111 :firstsecond1 = 8'b00110001;
        8'b00100000 :firstsecond1 = 8'b00110010;
        8'b00100001 :firstsecond1 = 8'b00110011;
        8'b00100010 :firstsecond1 = 8'b00110100;
        8'b00100011 :firstsecond1 = 8'b00110101;
        8'b00100100 :firstsecond1 = 8'b00110110;
        8'b00100101 :firstsecond1 = 8'b00110111;
        8'b00100110 :firstsecond1 = 8'b00111000;
        8'b00100111 :firstsecond1 = 8'b00111001;//39
        8'b00101000 :firstsecond1 = 8'b01000000;
        8'b00101001 :firstsecond1 = 8'b01000001;
        8'b00101010 :firstsecond1 = 8'b01000010;
        8'b00101011 :firstsecond1 = 8'b01000011;
        8'b00101100 :firstsecond1 = 8'b01000100;
        8'b00101101 :firstsecond1 = 8'b01000101;
        8'b00101110 :firstsecond1 = 8'b01000110;
        8'b00101111 :firstsecond1 = 8'b01000111;
        8'b00110000 :firstsecond1 = 8'b01001000;
        8'b00110001 :firstsecond1 = 8'b01001001;
        8'b00110010 :firstsecond1 = 8'b01010000;
        8'b00110011 :firstsecond1 = 8'b01010001;//51
        8'b00110100 :firstsecond1 = 8'b01010010;//52 
        8'b00110101 :firstsecond1 = 8'b01010011;// 
        8'b00110110 :firstsecond1 = 8'b01010100;// 
        8'b00110111 :firstsecond1 = 8'b01010101;    
        8'b00111000 :firstsecond1 = 8'b01010110;    
        8'b00111001 :firstsecond1 = 8'b01010111;    
        8'b00111010 :firstsecond1 = 8'b01011000;    
        8'b00111011 :firstsecond1 = 8'b01011001;// 
        8'b00111100 :firstsecond1 = 8'b01100000; //60  
        8'b00111101 :firstsecond1 = 8'b01100001;// 
        8'b00111110 :firstsecond1 = 8'b01100010;//
        8'b00111111 :firstsecond1 = 8'b01100011;
        8'b01000000 :firstsecond1 = 8'b01100100;
        8'b01000001 :firstsecond1 = 8'b01100101;
        8'b01000010 :firstsecond1 = 8'b01100110;
        8'b01000011 :firstsecond1 = 8'b01100111;
        8'b01000100 :firstsecond1 = 8'b01101000;    
        8'b01000101 :firstsecond1 = 8'b01101001;//69    
        8'b01000110 :firstsecond1 = 8'b01110000;//70    
        8'b01000111 :firstsecond1 = 8'b01110001;    
        8'b01001000 :firstsecond1 = 8'b01110010;
        8'b01001001 :firstsecond1 = 8'b01110011;
        8'b01001010 :firstsecond1 = 8'b01110100;    
        8'b01001011 :firstsecond1 = 8'b01110101;    
        8'b01001100 :firstsecond1 = 8'b01110110;    
        8'b01001101 :firstsecond1 = 8'b01110111;
        8'b01001110 :firstsecond1 = 8'b01111000;    
        8'b01001111 :firstsecond1 = 8'b01111001;//79    
        8'b01010000 :firstsecond1 = 8'b10000000;//80    
        8'b01010001 :firstsecond1 = 8'b10000001;
        8'b01010010 :firstsecond1 = 8'b10000010;    
        8'b01010011 :firstsecond1 = 8'b10000011;    
        8'b01010100 :firstsecond1 = 8'b10000100;    
        8'b01010101 :firstsecond1 = 8'b10000101;    
        8'b01010110 :firstsecond1 = 8'b10000110;    
        8'b01010111 :firstsecond1 = 8'b10000111;    
        8'b01011000 :firstsecond1 = 8'b10001000;    
        8'b01011001 :firstsecond1 = 8'b10001001;//89    
        8'b01011010 :firstsecond1 = 8'b10010000;    
        8'b01011011 :firstsecond1 = 8'b10010001;
        8'b01011100 :firstsecond1 = 8'b10010010;    
        8'b01011101 :firstsecond1 = 8'b10010011;    
        8'b01011110 :firstsecond1 = 8'b10010100;    
        8'b01011111 :firstsecond1 = 8'b10010101;    
        8'b01100000 :firstsecond1 = 8'b10010110;    
        8'b01100001 :firstsecond1 = 8'b10010111;    
        8'b01100010 :firstsecond1 = 8'b10011000;    
        8'b01100011 :firstsecond1 = 8'b10011001;//99    
        //8'b01100100 :firstsecond1 = 8'b00000000;    
        
        default: firstsecond1 = 8'b10101010;
                
    endcase
 assign Btemp = firstsecond1;
endmodule
