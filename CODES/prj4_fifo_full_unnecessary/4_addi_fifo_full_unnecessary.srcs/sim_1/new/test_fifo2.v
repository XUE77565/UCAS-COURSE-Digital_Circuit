`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/04 22:17:04
// Design Name: 
// Module Name: test_fifo2
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


module test_fifo2(

    );
    
    reg clk,rstn;
    reg [7:0] data;
    wire [15:0] out;
    reg input_valid, output_enable;
    
    fifo2 test_sim_fifo(
        .clk(clk),
        .rstn(rstn),
        .input_valid(input_valid),
        .output_enable(output_enable),
        .data_in(data),
        .data_out(out)
     );
     
     always #2 begin
        clk = ~clk;
        end
    
     initial begin
        clk = 1'b0;
        rstn = 1'b1;
        input_valid = 1'b0;
        output_enable = 1'b0;
        #1 rstn = 1'b0;
        #2 rstn = 1'b1;
     end
     
     always begin
        #4;
        data = $random()%9'b1_0000_0000;    //������8λ
     end
     
     always begin
        #6;
        input_valid = 1'b1;
        output_enable = 1'b0;
        #6;
        input_valid = 1'b1;
        output_enable = 1'b1;
        #3;
        input_valid = 1'b0;
        output_enable = 1'b1;
        //$finish;
     end
endmodule
