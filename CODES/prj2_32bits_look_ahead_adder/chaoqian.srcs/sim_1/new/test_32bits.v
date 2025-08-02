`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/02 12:54:18
// Design Name: 
// Module Name: test_32bits
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


module test_32bits();

reg [31:0]A;
reg [31:0]B;
reg Cin;
wire [31:0]S;
wire Cout;

add32 test_add32 (
    .A(A[31:0]),
    .B(B[31:0]),
    .Cin(Cin),
    .S(S[31:0]),
    .Cout(Cout)
);

initial begin
    #2;
    A = 32'h11111111;
    B = 32'h00000000;
    Cin = 1'b0;
end

always begin
    #2
    A = $random()% 65536;
    B = $random()% 65536;
    Cin = $random()% 2;
end

endmodule
