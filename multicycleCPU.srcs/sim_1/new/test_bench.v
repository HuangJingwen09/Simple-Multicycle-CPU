`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/20 21:57:04
// Design Name: 
// Module Name: test_bench
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


module test_bench;
    reg clk;
    reg RST;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [31:0] readData1;
    wire [31:0] readData2; 
    wire [31:0] InsData;
    wire [31:0] memData; 
    wire [31:0] result;
    wire [31:0] curPC;
    wire [31:0] nextPC; 
    wire [31:0] BusData;
    wire [2:0] state;
    MulticycleCPU_top top(clk, RST, rs, rt, state, readData1, readData2, InsData, memData, result, curPC, nextPC, BusData);
    
    initial begin
                // Initialize Inputs
                clk = 0;
                RST = 0;
                #50; // 刚开始设置pc为0
                    clk = 1;
                #50;
                    RST = 1;
                forever #50 begin // 产生时钟信号
                    clk = !clk;
                end
        end
endmodule
