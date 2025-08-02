`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/02 21:21:40
// Design Name: 
// Module Name: add_test
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


module add_test();

reg [3:0]A;
reg [3:0]B;
reg Cin;
wire [3:0]S;
wire Cout;
wire [3:0]C;
wire p;
wire g;

add test_add (
    .A(A[3:0]),
    .B(B[3:0]),
    .Cin(Cin),
    .S(S[3:0]),
    .Cout(Cout),
    .C(C[3:0]),
    .p(p),
    .g(g)
);

initial begin
    #2;
    A = 4'b0000;
    B = 4'b0000;
    Cin = 1'b0;
end

always begin
    #2
    A = $random()% 16;
    B = $random()% 16;
    Cin = $random()% 2;
end

endmodule
