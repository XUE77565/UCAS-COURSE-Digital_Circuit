`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/18 21:24:38
// Design Name: 
// Module Name: check_newpaper_machine
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


module check_newpaper_machine(
    );
    
reg [1:0]in;
reg clk;
reg rstn;
wire out;

newspaper_machine start(
    .clk(clk),
    .in(in),
    .rstn(rstn),
    .out(out)
);

initial begin
    clk = 0;
    in = 0;
    rstn = 1;
    #0.1 rstn = 0;
    #1.1 rstn = 1;
end

always begin
    #1 clk = ~clk;
end

always begin
    #2 in = $urandom_range(2, 0);
end

endmodule
