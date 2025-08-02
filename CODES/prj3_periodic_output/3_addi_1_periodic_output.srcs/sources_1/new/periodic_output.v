`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/18 20:52:52
// Design Name: 
// Module Name: periodic_output
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


module periodic_output(
    input clk,
    input rstn,
    output reg out
    );
    
    parameter s0 = 4'b0000;
    parameter s1 = 4'b0001;
    parameter s2 = 4'b0010;
    parameter s3 = 4'b0011;
    parameter s4 = 4'b0100;
    parameter s5 = 4'b0101;
    parameter s6 = 4'b0110;
    parameter s7 = 4'b0111;
    parameter s8 = 4'b1000;
    parameter s9 = 4'b1001;
    parameter s10 = 4'b1010;
    parameter s11 = 4'b1011;
    parameter s12 = 4'b1100;
    parameter s13 = 4'b1101;
    parameter s14 = 4'b1110;
    parameter s15 = 4'b1111;
    
    reg [3:0]state;
    reg [3:0]next_state;
    
    always @(negedge rstn or posedge clk)begin
        if(!rstn)begin
            state <= s0;
        end
        else begin
            state <= next_state;
        end
    end
  

    always @(state)begin
        case(state)
            s0: next_state = s1;
            s1: next_state = s2;
            s2: next_state = s3;
            s3: next_state = s4;
            s4: next_state = s5;
            s5: next_state = s6;
            s6: next_state = s7;
            s7: next_state = s8;
            s8: next_state = s9;
            s9: next_state = s10;
            s10: next_state = s11;
            s11: next_state = s0;
            default: next_state = s0;
        endcase
    end
    
    
    
    always @(state)begin
        case(state)
            s0: out = 0;
            s1: out = 0;
            s2: out = 1;
            s3: out = 0;
            s4: out = 1;
            s5: out = 0;
            s6: out = 0;
            s7: out = 1;
            s8: out = 1;
            s9: out = 0;
            s10: out = 1;
            s11: out = 1;
            default: out = 1'bx;
        endcase
    end

endmodule
