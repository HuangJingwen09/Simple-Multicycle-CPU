`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/20 20:49:44
// Design Name: 
// Module Name: DataMem
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


module DataMem(
    input clk,
    input mRD,
    input mWR,
    input [31:0] Addr,
    input [31:0] StoreData,
    output [31:0] memData
    );
    
    reg [7:0] dataMem [0:60];
    assign memData[31:24] = (mRD == 1)? dataMem[Addr] : 8'bz;
    assign memData[23:16] = (mRD == 1)? dataMem[Addr + 1] : 8'bz;
    assign memData[15:8] = (mRD == 1)? dataMem[Addr + 2] : 8'bz;
    assign memData[7:0] = (mRD == 1)? dataMem[Addr + 3] : 8'bz;
        
    always@(posedge clk) begin
        if(mWR == 1) begin
            dataMem[Addr] = StoreData[31:24];
            dataMem[Addr + 1] = StoreData[23:16];
            dataMem[Addr + 2] = StoreData[15:8];
            dataMem[Addr + 3] = StoreData[7:0];
        end
    end
    
endmodule
