`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/02 11:16:17
// Design Name: 
// Module Name: add_16
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


module add_16(
    input [15:0]A,
    input [15:0]B,
    input Cin,
    output Cout,
    output [15:0]S,
    output p,
    output g
    );
    wire[3:0]P;
    wire[3:0]G;
    wire[3:0]C;
    wire a;
    wire b;
    
    assign C[0]=Cin;
    
    add pre1(
        .A(A[3:0]),
        .B(B[3:0]),
        .p(P[0]),
        .g(G[0])
    );
    
    add pre2(
        .A(A[7:4]),
        .B(B[7:4]),
        .p(P[1]),
        .g(G[1])
    );
    
    add pre3(
        .A(A[11:8]),
        .B(B[11:8]),
        .p(P[2]),
        .g(G[2])
    );
    
    add pre4(
        .A(A[15:12]),
        .B(B[15:12]),
        .p(P[3]),
        .g(G[3])
    );
    
    add4_inputPG outC(
        .P(P[3:0]),
        .G(G[3:0]),
        .Cin(Cin),
        .C(C[3:0]),
        .Cout()
    );
    
    add add1(
        .A(A[3:0]),
        .B(B[3:0]),
        .Cin(Cin),
        .S(S[3:0]),
        .C(),
        .Cout(),
        .p(),
        .g()
    );
    
    add add2(
        .A(A[7:4]),
        .B(B[7:4]),
        .Cin(C[1]),
        .C(),
        .S(S[7:4]),
        .Cout(),
        .p(),
        .g()
    );
    
    add add3(
        .A(A[11:8]),
        .B(B[11:8]),
        .Cin(C[2]),
        .C(),
        .S(S[11:8]),
        .Cout(),
        .p(),
        .g()        
    );
    
    add add4(
        .A(A[15:12]),
        .B(B[15:12]),
        .Cin(C[3]),
        .C(),
        .S(S[15:12]),
        .Cout(Cout),
        .p(),
        .g()
    );
    
    assign p=P[3]&P[2]&P[1]&P[0];
    assign g=G[3] | P[3]&G[2] | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0];
    
endmodule
