`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/18 20:21:32
// Design Name: 
// Module Name: check_str
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


module check_str(
    input clk,
    input in,
    input rstn,
    output reg out
);
    parameter s0 = 3'b000;
    parameter s1 = 3'b001;
    parameter s2 = 3'b010;
    parameter s3 = 3'b011;
    parameter s4 = 3'b100;
 //ÎÞ¹Ø×´Ì¬
    parameter s5n = 3'b101;
    parameter s6n = 3'b110;
    parameter s7n = 3'b111;
    
    reg [2:0]state;
    reg [2:0]next_state;
    
    
    
    always @(negedge rstn or posedge clk)begin
        if(!rstn)begin
            state <= s0;
        end
        else begin
            state <= next_state;
        end
    end
        
        
        
    always @(state or in)begin
        case(state)
        s0:begin
            case(in)
            0 : next_state = s1;
            1 : next_state = s0;
            endcase
        end
        s1:begin
            case(in)
            0 : next_state = s1;
            1 : next_state = s2;
            endcase
        end
        s2:begin
            case(in)
            0 : next_state = s1;
            1 : next_state = s3;
            endcase
        end
        s3:begin
            case(in)
            0 : next_state = s4;
            1 : next_state = s0;
            endcase
        end
        s4:begin
            case(in)
            0 : next_state = s1;
            1 : next_state = s2;
        default: next_state=s0;
            endcase
        end
        endcase
   end
   
   

    always@(state)begin
        case(state)
        s0: out = 1'b0;
        s1: out = 1'b0;
        s2: out = 1'b0;
        s3: out = 1'b0;
        s4: out = 1'b1;
        default: out=1'bx;
        endcase
    end
    
endmodule