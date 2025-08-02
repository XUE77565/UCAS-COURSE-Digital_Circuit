`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/02 22:05:11
// Design Name: 
// Module Name: test16
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


module test16();
reg [15:0]A;
reg [15:0]B;
reg Cin;
wire [15:0]S;
wire Cout;

add_16 test_add16 (
    .A(A[15:0]),
    .B(B[15:0]),
    .Cin(Cin),
    .S(S[15:0]),
    .Cout(Cout)
);

initial begin
    #2;
    A = 16'h0000;
    B = 16'h0000;
    Cin = 1'b0;
end

always begin
    #2
    A = $random()% 2048;
    B = $random()% 2048;
    Cin = $random()% 2;
end

endmodule
