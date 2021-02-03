`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/21 09:02:47
// Design Name: 
// Module Name: SelectNums
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


module SelectNums(
    input [15:0] sw,
    input [4:0] rs,
    input [4:0] rt,
    input [31:0] readData1,
    input [31:0] readData2,
    input [31:0] result,
    input [31:0] BusData,
    input [31:0] curPC,
    input [31:0] nextPC,
    output reg [3:0] numl_1,
    output reg [3:0] numl_2, 
    output reg [3:0] numr_1, 
    output reg [3:0] numr_2
    );
  
    always@(sw) begin
        if(sw == 16'b0100000000000001) begin
            numl_1[3:1] = 3'b000;
            numl_1[0] = rs[4];
            numl_2 = rs[3:0];
            numr_1 = readData1[7:4];
            numr_2 = readData1[3:0];
        end
        else if(sw == 16'b1000000000000001) begin
            numl_1[3:1] = 3'b000;
            numl_1[0] = rt[4];
            numl_2 = rt[3:0];
            numr_1 = readData2[7:4];
            numr_2 = readData2[3:0];
        end
        else if(sw == 16'b1100000000000001) begin
            numl_1 = result[7:4];
            numl_2 = result[3:0];
            numr_1 = BusData[7:4];
            numr_2 = BusData[3:0];
        end
        else if(sw == 16'b0000000000000001) begin
            numl_1 = curPC[7:4];
            numl_2 = curPC[3:0];
            numr_1 = nextPC[7:4];
            numr_2 = nextPC[3:0];
        end
    end
endmodule
