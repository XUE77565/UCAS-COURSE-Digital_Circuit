`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/18 21:09:19
// Design Name: 
// Module Name: newspaper_machine
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


module newspaper_machine(
    input [1:0]in,
    input clk,
    input rstn,
    output reg out
    );
    
    reg [2:0]state;
    reg [2:0]next_state;
    
    parameter s0 = 3'b000;
    parameter s1 = 3'b001;
    parameter s2 = 3'b010;
    parameter s3 = 3'b011;
    parameter s4 = 3'b100;
    parameter s5 = 3'b101;
    parameter s6 = 3'b110;
    parameter reset = 3'b111;
    
    always @(negedge rstn or posedge clk)begin
        if(!rstn)begin
            state <= s0;
        end
        else begin
            state <= next_state;
        end
    end
    
    
    always @(in or state)begin//in中0,1,2分别表示1,2,5分钱
        case(state)
            s0:case(in)
                   2'b00: next_state = s1;
                   2'b01: next_state = s2;
                   2'b10: next_state = s5;
               endcase
            s1:case(in)
                   2'b00: next_state = s2;
                   2'b01: next_state = s3;
                   2'b10: next_state = reset;
               endcase
            s2:case(in)
                   2'b00: next_state = s3;
                   2'b01: next_state = s4;
                   2'b10: next_state = reset;
               endcase
            s3:case(in)
                   2'b00: next_state = s4;
                   2'b01: next_state = s5;
                   2'b10: next_state = reset;
               endcase
            s4:case(in)
                   2'b00: next_state = s5;
                   2'b01: next_state = reset;
                   2'b10: next_state = reset;
               endcase
            reset: next_state = s0;
            default: next_state = reset;
        endcase
    end
    
    always @(state) begin
        case(state)
            s5: out = 1;
            reset: out = 1'b0;
            default: out = 0;
        endcase
    end
    
endmodule
