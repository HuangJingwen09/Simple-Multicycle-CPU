`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/20 19:01:47
// Design Name: 
// Module Name: PCAdder
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


module PCAdder(
    input RST,
    input [1:0] PCSrc,
    input [31:0] imm,
    input [25:0] addr,
    input [31:0] curPC,
    input [31:0] readData1,
    output reg[31:0] nextPC
    );
    
    initial begin
        nextPC = 0;
    end
    reg [31:0] tmp;
    always@(PCSrc or imm or addr or curPC or readData1) begin
        if(!RST) begin
            nextPC = 0;
        end
        else begin
            tmp = curPC + 4;
            case(PCSrc) 
                2'b00: nextPC = tmp;
                2'b01: nextPC = curPC + 4 + imm * 4;
                2'b10: nextPC = readData1;
                2'b11: nextPC = {tmp[31:28], addr, 2'b00};
            endcase
        end
    end
endmodule
