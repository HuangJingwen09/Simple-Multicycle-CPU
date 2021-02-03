`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/21 13:33:37
// Design Name: 
// Module Name: LED
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


module LED(    
    input [3:0] numl_1,
    input [3:0] numl_2,
    input [3:0] numr_1,
    input [3:0] numr_2,
    input clk,
    output reg [6:0] a_to_g,
    output reg [3:0] an,
    output wire dp
    );
   	 
    wire [1:0] s;     
    reg [3:0] digit;
    wire [3:0] aen;
    reg [19:0] clkdiv;

    assign dp = 1;
    assign s = clkdiv[19:18];
    assign aen = 4'b1111; // all turned off initially

    // quad 4to1 MUX.


    always @(posedge clk)// or posedge clr)
   
        case(s)
            0:digit = numr_2; // s is 00 -->0 ;  digit gets assigned 4 bit value assigned to x[3:0]
            1:digit = numr_1; // s is 01 -->1 ;  digit gets assigned 4 bit value assigned to x[7:4]
            2:digit = numl_2; // s is 10 -->2 ;  digit gets assigned 4 bit value assigned to x[11:8
            3:digit = numl_1; // s is 11 -->3 ;  digit gets assigned 4 bit value assigned to x[15:12]
   
            default:digit = numr_2;
   
        endcase
   
   //decoder or truth-table for 7a_to_g display values
   always @(*)

        case(digit)


        //////////<---MSB-LSB<---
        //////////////gfedcba////////////////////////////////////////////         a
0:a_to_g = 7'b1000000;////0000                                                   __                    
1:a_to_g = 7'b1111001;////0001                                                f|   |b
2:a_to_g = 7'b0100100;////0010                                                  g
        //                                                                      ¡ª    
3:a_to_g = 7'b0110000;////0011                                              e |  |c
4:a_to_g = 7'b0011001;////0100                                                 ¡ª
5:a_to_g = 7'b0010010;////0101                                                 d 
6:a_to_g = 7'b0000010;////0110
7:a_to_g = 7'b1111000;////0111
8:a_to_g = 7'b0000000;////1000
9:a_to_g = 7'b0010000;////1001
'hA : a_to_g = 7'b0001000; //A 
'hB : a_to_g = 7'b0000011; //b 
'hC : a_to_g = 7'b1000110; //C 
'hD : a_to_g = 7'b0100001; //d 
'hE : a_to_g = 7'b0000110; //E 
'hF : a_to_g = 7'b0001110; //F 
default : a_to_g = 7'b111111; //²»ÁÁ

endcase


always @(*)begin
an=4'b1111;
if(aen[s] == 1)
an[s] = 0;
end


//clkdiv

always @(posedge clk) begin
clkdiv <= clkdiv+1;
end
endmodule
