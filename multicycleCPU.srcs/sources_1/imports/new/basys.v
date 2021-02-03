`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/21 10:35:59
// Design Name: 
// Module Name: basys
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


module basys(
    input clk,
    input [15:0] sw,
    input btnR,
    output [15:0] led,
    output [6:0] seg,
    output [3:0] an, 
    output dp
    );
    wire RST;
    wire [3:0] numl_1,numl_2, numr_1, numr_2;
    wire [2:0] state;
    wire [31:0] tmp_readData1, tmp_readData2, InsData, memData, tmp_result, curPC, nextPC, BusData;
    wire [4:0] rs, rt;
    
    reg clock;
    reg [27:0] cnt = 0;
    always@(*) begin
        if(btnR == 1) begin
            clock = 1;
        end
        else if(cnt == 48000000) begin
            clock = 0;
        end
    end
    always@(posedge clk)
    begin
        if(clk == 1)//如果状态置一
        cnt<=cnt+1'b1;//开始计数
        else
        cnt<=0;//松开或没有按下,清零
    end
    
    assign RST = sw[0];
    assign led[15:0] = sw[15:0];
    MulticycleCPU_top top(clock, RST, rs, rt, state, tmp_readData1, tmp_readData2, InsData, memData, tmp_result, curPC, nextPC, BusData);
    
    SelectNums sn(sw, rs, rt, tmp_readData1, tmp_readData2, tmp_result, BusData, curPC, nextPC, numl_1, numl_2, numr_1, numr_2);
    LED leddisplay(numl_1, numl_2, numr_1, numr_2, clk, seg, an, dp);
    
endmodule
