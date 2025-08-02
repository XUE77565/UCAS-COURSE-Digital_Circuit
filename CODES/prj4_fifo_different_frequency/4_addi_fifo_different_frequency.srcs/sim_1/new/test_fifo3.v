`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/04 22:37:20
// Design Name: 
// Module Name: test_fifo3
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


module test_fifo3(

    );
    
    reg clk,rstn;
    reg [15:0] data;
    wire [7:0] out;
    reg input_valid, output_enable;
    
    fifo3 test_sim_fifo(
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
        #2;
        data = $random()%17'b1_0000_0000_0000_0000;    // ‰»Î «8Œª
     end
     
     always begin
        #4;
        input_valid =0;
        #4;
        input_valid =1;
    end
    
    always begin
        #6;
        output_enable =0;
        #6;
        output_enable =1;
    end
endmodule
