`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/02 10:55:44
// Design Name: 
// Module Name: add32
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


module add32(
    input [31:0]A,
    input [31:0]B,
    input Cin,
    output [31:0]S,
    output Cout
 );
 
 wire [1:0]C;wire p0;wire g0;
 
 assign C[0]=Cin;
 
 add_16 pre(
    .A(A[15:0]),
    .B(B[15:0]),
    .Cin(C[0]),
    .S(),
    .p(p0),
    .g(g0)
 );
 
 assign C[1]=g0 | (p0 & Cin);
 
 add_16 add1(
    .A(A[15:0]),
    .B(B[15:0]),
    .Cin(C[0]),
    .S(S[15:0]),
    .Cout(),
    .p(),
    .g()
 );
 
  add_16 add2(
    .A(A[31:16]),
    .B(B[31:16]),
    .Cin(C[1]),
    .S(S[31:16]),
    .Cout(Cout),
    .p(),
    .g()
 );
    

endmodule
