`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/20 19:50:52
// Design Name: 
// Module Name: RegFile
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


module RegFile(
    input clk,
    input RegWre,
    input [4:0] ReadReg1,
    input [4:0] ReadReg2,
    input [4:0] rd,
    input [1:0] RegDst,
    input WrRegDSrc,
    input [31:0] BusData,
    input [31:0] curPC,
    output [31:0] readData1,
    output [31:0] readData2
    );
    reg [31:0] WriteData;
    reg [5:0] DstReg;
    reg [31:0] register[0:31];
    integer i;
    initial begin
        for(i = 0;i < 32;i = i + 1) register[i] <= 0;
    end
    assign readData1 = register[ReadReg1];  //把数据放在readData上了
    assign readData2 = register[ReadReg2];
    
    always@(*) begin
        case(RegDst)
            2'b00: DstReg = 5'b11111;
            2'b01: DstReg = ReadReg2;
            2'b10: DstReg = rd;
        endcase
    end
    always@(*) begin
        if(WrRegDSrc == 1) begin
            WriteData = BusData;
        end
        else begin
            WriteData = curPC + 4;
        end
    end
    
    always@(negedge clk) begin
        if(RegWre == 1) begin
            register[DstReg] <= WriteData;
        end
    end
endmodule






