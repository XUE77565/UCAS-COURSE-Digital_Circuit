`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/18 21:04:06
// Design Name: 
// Module Name: test_periodic_output
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


module test_periodic_output(

    );
    
reg clk;
reg rstn;
wire out;

periodic_output start(
    .clk(clk),
    .rstn(rstn),
    .out(out)
);

initial begin
    clk = 0;
    rstn = 1;
    #0.1 rstn = 0;
    #1.1 rstn = 1;
end

always begin
    #1 clk = ~clk;
end

endmodule
