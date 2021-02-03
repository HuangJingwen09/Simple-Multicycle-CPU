`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/20 14:18:26
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
       input CLK,
       input RST,
       input zero,
       input sign,
       input [5:0] op,
       input [5:0] func,
       output reg IRWre,  
       output reg PCWre,   
       output reg ExtSel, 
       output reg InsMemRW,    
       output reg WrRegDSrc,  
       output reg [1:0] RegDst,
       output reg RegWre,   
       output reg ALUSrcA,  
       output reg ALUSrcB,   
       output reg [1:0] PCSrc,  
       output reg [2:0] ALUop,  
       output reg mRD, 
       output reg mWR,  
       output reg DBDataSrc,
       output reg [2:0] state
    );
    
    reg [2:0] nextstate;
    initial begin
           PCWre = 0;  
           InsMemRW = 0;  
           IRWre = 0;  
           RegWre = 0;   
           ExtSel = 0;  
           PCSrc = 2'b00;  
           RegDst = 2'b11;
           ExtSel = 0;
           WrRegDSrc = 0;
           ALUSrcA = 0;
           ALUSrcB = 0;
           DBDataSrc = 0;
           mRD = 0;
           mWR = 0;
           ALUop = 3'bzzz;
       end
    initial begin
        state = 3'bzzz;
        nextstate = 3'b000;
    end
    
    always@(posedge CLK) begin
        if(RST) begin
            state <= nextstate;
        end
    end
    
    always@(state or op or zero or sign or func) begin
        case(state)
            3'b000:
                nextstate = 3'b001;
            3'b001:
                if((op == 6'b000000 && func != 6'b001000) || op == 6'b001001 || op == 6'b001010 || op == 6'b001100 || op == 6'b001101 || op == 6'b001110) begin
                    nextstate = 3'b110;
                end
                else if(op == 6'b000101 || op == 6'b000100 || op == 6'b000001) begin
                    nextstate = 3'b101;
                end
                else if(op == 6'b100011 || op == 6'b101011) begin
                    nextstate = 3'b010;
                end
                else if(op == 6'b000010 || op == 6'b000011 || (op == 6'b000000 && func == 6'b001000) || op == 6'b111111) begin
                    nextstate = 3'b000;
                end
            3'b110:
                nextstate = 3'b111;
            3'b101:
                nextstate = 3'b000;
            3'b010:
                nextstate = 3'b011;
            3'b011:
                if(op == 6'b100011) begin
                    nextstate = 3'b100;
                end
                else begin
                    nextstate = 3'b000;
                end
            3'b111:
                nextstate = 3'b000;
            3'b100:
                nextstate = 3'b000;
        endcase
        
        if(nextstate == 3'b000 && op != 6'b111111) begin            //PCWre
            PCWre = 1;
        end
        else begin
            PCWre = 0;
        end
        
        if(state == 3'b110 && func == 6'b000000) begin          //ALUSrcA
            ALUSrcA = 1;
        end
        else ALUSrcA = 0;
        
        if(state == 3'b110) begin                               //ALUSrcB
            if(op == 6'b000000) begin
                ALUSrcB = 0;
            end
            else begin
                ALUSrcB = 1;
            end
        end
        if(state == 3'b101) begin
            ALUSrcB = 0;
        end
        if(state == 3'b010) begin
            ALUSrcB = 1;
        end
        
        if(state == 3'b111) begin
            DBDataSrc = 0;
        end
        if(state == 3'b100) begin
            DBDataSrc = 1;
        end
        if(state == 3'b011) begin
            if(op == 6'b100011) begin
                DBDataSrc = 1;
            end
            else if(op == 6'b101011) begin
                DBDataSrc = 0;
            end
        end
        
        if(state == 3'b000 || state == 3'b110 || state == 3'b101 || state == 3'b010) begin      //RegWre
            RegWre = 0;
        end
        else if(state == 3'b111 || state == 3'b100) begin
            RegWre = 1;
        end
        else if(state == 3'b001) begin
            if(op == 6'b000011) begin
                RegWre = 1;
            end
            else begin
                RegWre = 0;
            end
        end
        else if(state == 3'b011) begin
                RegWre = 0;
        end
        
        if(state == 3'b001 && op == 6'b000011) begin                //WrRegDSrc
            WrRegDSrc = 0;
        end
        else begin
            WrRegDSrc = 1;
        end
        
        if(state == 3'b000 && op != 6'b111111) begin                //InsMemRW
            InsMemRW = 1;
        end
        else begin
            InsMemRW = 0;
        end
        
        if((state == 3'b011 || state == 3'b100) && op == 6'b100011) begin                //mRD
            mRD = 1;
        end
        else begin
            mRD = 0;
        end
        
        if(state == 3'b011 && op == 6'b101011) begin                //mWR
            mWR = 1;
        end
        else begin
            mWR = 0;
        end
        
        if(state == 3'b000 && op != 6'b111111) begin                //IRWre
            IRWre = 1;
        end
        else begin
            IRWre = 0;
        end
        
        if(state == 3'b001) begin                   //ExtSel
            if(op == 6'b001001 || op == 6'b001010 || op == 6'b000101 || op == 6'b000100 || op == 6'b000001) begin
                ExtSel = 1;
            end
            else if(op == 6'b001100 || op == 6'b001101 || op == 6'b001110) begin
                ExtSel = 0;
            end
        end
        
        
        
        if(state == 3'b001) begin                   //PCSrc
            if(op == 6'b000010 || op == 6'b000011) begin
                PCSrc = 2'b11;
            end
            if(op == 6'b000000) begin
                if(func == 6'b001000) begin
                    PCSrc = 2'b10;
                end
                else begin
                    PCSrc = 2'b00;
                end
            end
        end
        else if(state == 3'b110 || state == 3'b010) begin
            PCSrc = 2'b00;
        end
        else if(state == 3'b101) begin
            if(op == 6'b000101) begin
                if(zero == 0) begin
                    PCSrc = 2'b01;
                end
                else begin
                    PCSrc = 2'b00;
                end
            end
            else if(op == 6'b000100) begin
                if(zero == 1) begin
                    PCSrc = 2'b01;
                end
                else begin
                    PCSrc = 2'b00;
                end
            end
            else if(op == 6'b000001) begin
                if(sign == 1) begin
                    PCSrc = 2'b01;
                end
                else begin
                    PCSrc = 2'b00;
                end
            end
        end
        else begin
            PCSrc = 2'b00;
        end
        
        if(state == 3'b001 && op == 6'b000011) begin            //RegDst
            RegDst = 2'b00;
        end
        else if((state == 3'b011 && op == 6'b100011) || state == 3'b100) begin
            RegDst = 2'b01;
        end
        else if(state == 3'b111) begin
            if(op == 6'b000000) begin
                RegDst = 2'b10;
            end
            else begin
                RegDst = 2'b01;
            end
        end
        
        if(state == 3'b110 || state == 3'b101 || state == 3'b010) begin
            if((state == 3'b110 && (op == 6'b001001 || (op == 6'b000000 && func == 6'b100000))) || state == 3'b010) begin
                ALUop = 3'b000;
            end
            else if((state == 3'b101) || (state == 3'b110 && (op == 6'b000000 && func == 6'b100010))) begin
                ALUop = 3'b001;
            end
            else if(state == 3'b110 && ((op == 6'b000000 && func == 6'b100100) || op ==6'b001100)) begin
                ALUop = 3'b100;
            end
            else if(state == 3'b110 && ((op == 6'b000000 && func == 6'b100101) || op ==6'b001101)) begin
                ALUop = 3'b011;
            end
            else if(state == 3'b110 && ((op == 6'b000000 && func == 6'b101010) || op ==6'b001010)) begin
                ALUop = 3'b110;
            end
            else if(state == 3'b110 && op == 6'b000000 && func == 6'b000000) begin
                ALUop = 3'b010;
            end
            else if(state == 3'b110 && op == 6'b001110) begin
                ALUop = 3'b111;
            end
        end
        else begin
            ALUop = 3'bzzz;
        end
    end
    
endmodule






