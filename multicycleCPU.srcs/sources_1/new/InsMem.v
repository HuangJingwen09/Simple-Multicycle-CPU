`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/20 19:23:19
// Design Name: 
// Module Name: InsMem
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


module InsMem(
    input [31:0] InsAddr,
    input InsMemRW,
    output reg[31:0] InsData
    );
    reg [7:0] mem [255:0];  
    initial
    begin
        $readmemb("C:/Users/45595/Desktop/vivado_projs/multicycleCPU/InsData.txt", mem);
        InsData = 0;
    end
    always@(InsMemRW or InsAddr) begin
        if(InsMemRW == 1) begin
            InsData[31:24] = mem[InsAddr];  //写InsData.txt的时候其实就是按大端存储写的
            InsData[23:16] = mem[InsAddr+1];
            InsData[15:8] = mem[InsAddr+2];
            InsData[7:0] = mem[InsAddr+3];
        end
    end
endmodule
