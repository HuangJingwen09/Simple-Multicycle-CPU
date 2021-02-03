`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/20 19:24:54
// Design Name: 
// Module Name: InsReg
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


module InsReg(
    input [31:0] inputIns,
    input clk,
    input IRWre,
    output reg[5:0] op,
    output reg[4:0] rs,
    output reg[4:0] rt,
    output reg[4:0] rd,
    output reg[4:0] sa,
    output reg[15:0] immediate,
    output reg[25:0] addr,
    output reg[5:0] func
    );
    reg[31:0] outputIns;
    
    initial begin
        outputIns = 0;
    end
    
    always@(posedge clk)begin
        if(IRWre) begin
            outputIns <= inputIns;
        end
    end
    
    always@(outputIns) begin        //ÒëÂë
        op = outputIns[31:26];
        rs = outputIns[25:21];
        rt = outputIns[20:16];
        rd = outputIns[15:11];
        sa = outputIns[10:6];
        func = outputIns[5:0];
        immediate = outputIns[15:0];
        addr = outputIns[25:0];
    end
endmodule







