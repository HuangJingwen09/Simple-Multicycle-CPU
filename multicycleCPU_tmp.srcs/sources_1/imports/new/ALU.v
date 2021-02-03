`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/20 18:43:18
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [2:0] ALUop,
    input ALUSrcA,
    input ALUSrcB,
    input [31:0] readData1,
    input [31:0] readData2,
    input [4:0] sa,
    input [31:0] imExt,
    output reg zero,
    output reg sign,
    output reg [31:0] result
    );
    
    wire [31:0] A;
    wire [31:0] B;
    assign A = (ALUSrcA == 1 ? sa : readData1);
    assign B = (ALUSrcB == 0 ? readData2 : imExt);
        
        always@(ALUop or A or B) begin
                if(ALUop == 3'b000) begin
                    result = A + B;
                    zero = (result == 0 ? 1:0);
                end
                else if(ALUop == 3'b001) begin
                    result = A - B;
                    zero = (result == 0 ? 1:0);
                    sign = result[31];
                end
                else if(ALUop == 3'b011) begin
                    result = A | B;
                    zero = (result == 0 ? 1:0);
                end
                else if(ALUop == 3'b100) begin
                    result = A & B;
                    zero = (result == 0 ? 1:0);
                end
                else if(ALUop == 3'b010) begin
                    result = B << A;
                    zero = (result == 0 ? 1:0);
                end
                else if(ALUop == 3'b110) begin
                    result = (((A < B) && (A[31] == B[31] ))||((A[31] == 1 && B[31] == 0))) ? 1:0;  //有符号数比较大小
                    zero = (result == 0 ? 1:0);
                end
                else if(ALUop == 3'b111) begin
                    result = A ^ B;
                    zero = (result == 0 ? 1:0);
                end
            end
endmodule
