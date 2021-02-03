`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/20 20:55:15
// Design Name: 
// Module Name: ImmExt
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


module ImmExt(
    input ExtSel,
    input wire [15:0] immediate,
    output [31:0] extended
    );
    
    assign extended[15:0] = immediate;
    assign extended[31:16] = ExtSel ? (immediate[15] == 1 ? 16'b1111111111111111 : 16'b0000000000000000) : 16'b0000000000000000;
     
endmodule
