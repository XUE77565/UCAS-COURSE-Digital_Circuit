`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/18 20:26:45
// Design Name: 
// Module Name: test_check_str
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


module test_check_str(

    );
    
    reg clk;
    reg rstn;
    reg a;
    wire out;
    
    check_str check(
        .clk(clk),
        .rstn(rstn),
        .in(a),
        .out(out)
    );
    
    initial begin
        clk=0;
        rstn=1;
        a=0;
        #0.1 rstn=0;
        #1.1 rstn=1;
    end
    
    always begin
        #1 clk = ~clk;
    end
    
    always begin
        #2 a = $random() % 2;
    end
    
endmodule
