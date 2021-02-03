`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/20 21:05:10
// Design Name: 
// Module Name: MulticycleCPU_top
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
`include    "ALU.v"
`include    "PC.v"
`include    "ControlUnit.v"
`include    "DBDReg.v"
`include    "DataMem.v"
`include    "DataReg.v"
`include    "PCAdder.v"
`include    "InsMem.v"
`include    "InsReg.v"
`include    "RegFile.v"
`include    "ControlUnit.v"

module MulticycleCPU_top(
    input clk,
    input RST,
    output wire [4:0] rs, rt,
    output wire [2:0] state,
    output wire [31:0] tmp_readData1, tmp_readData2, InsData, memData, tmp_result, curPC, nextPC, BusData
    );
    wire[4:0] rd, sa;
    wire[15:0] imm;
    wire[25:0] addr;
    wire[31:0] imExt, readData1, readData2, result;
    wire[1:0] PCSrc, RegDst;
    wire[5:0] func, op;
    wire [2:0] ALUop;
    wire zero, sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre, ExtSel;

    ControlUnit cu(clk, RST, zero, sign, op, func, IRWre, PCWre, ExtSel, InsMemRW, WrRegDSrc, RegDst, RegWre, ALUSrcA, ALUSrcB, PCSrc, ALUop, mRD, mWR, DBDataSrc, state);
    
    InsMem im(curPC, InsMemRW, InsData);
    
    InsReg ir(InsData, clk, IRWre, op, rs, rt, rd, sa, imm, addr, func);
    
    PCAdder pca(RST, PCSrc, imExt, addr, curPC, tmp_readData1, nextPC);
    
    DataMem dm(clk, mRD, mWR, result, readData2, memData);
    
    RegFile rf(clk, RegWre, rs, rt, rd, RegDst, WrRegDSrc, BusData, curPC, tmp_readData1, tmp_readData2);
    
    PC pc(clk, RST, PCWre, nextPC, curPC);
    
    ALU alu(ALUop, ALUSrcA, ALUSrcB, readData1, readData2, sa, imExt, zero, sign, tmp_result);
    
    ImmExt ie(ExtSel, imm, imExt);
    
    DBDReg dbdr(clk, memData, result, DBDataSrc, BusData);
    
    DataReg adr(clk, tmp_readData1, readData1);
    DataReg bdr(clk, tmp_readData2, readData2);
    DataReg aludr(clk, tmp_result, result);

endmodule








