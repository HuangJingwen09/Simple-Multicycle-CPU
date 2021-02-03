`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/20 21:01:50
// Design Name: 
// Module Name: DataReg
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


module DataReg(     //包括ALUSrcA、ALUSrcB以及ALUresult的数据寄存器
    input clk,
    input [31:0]inputData,
    output reg[31:0] outputData
    );
    
    initial begin
        outputData = 0;
    end
    
    always@(posedge clk) begin
        outputData <= inputData;
    end
    
endmodule
