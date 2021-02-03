`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/20 20:45:37
// Design Name: 
// Module Name: DBDReg
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


module DBDReg(
    input clk,
    input [31:0] MemData,
    input [31:0] ALUresult,
    input DBDataSrc,
    output reg[31:0] BusData
    );
    
    initial begin
        BusData = 0;
    end
    
    always@(ALUresult or MemData or DBDataSrc) begin
        if(DBDataSrc == 1) begin
            BusData <= MemData;
        end
        else begin
            BusData <= ALUresult;
        end
    end
    
endmodule
