`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/20 18:58:40
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input RST,
    input PCWre,
    input [31:0] nextPC,
    output reg[31:0] curPC
    );
    
    initial begin   
        curPC <= 0;
    end
    
    always@(posedge clk or negedge RST) begin
        if(!RST) begin
            curPC <= 0;
        end
        else begin
            if(PCWre == 1) begin
                curPC <= nextPC;
            end
            else begin
                curPC <= curPC;
            end
        end
    end
    
endmodule
