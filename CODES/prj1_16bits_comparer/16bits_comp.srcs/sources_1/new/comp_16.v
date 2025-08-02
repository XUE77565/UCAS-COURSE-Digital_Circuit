`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/02 10:23:08
// Design Name: 
// Module Name: comp_16
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


module comp_16(
    input [15:0]A,
    input [15:0]B,
    input in_A_G_B,
    output reg out_A_G_B,
    output reg out_A_E_B,
    output reg out_A_L_B
);

wire [3:0]G;
wire [3:0]E;
wire [3:0]L;

comp_4 comp0(
    .A(A[3:0]),
    .B(B[3:0]),
    .in_A_G_B(0),
    .in_A_E_B(1),
    .in_A_L_B(0),
    .out_A_G_B(G[0]),
    .out_A_E_B(E[0]),
    .out_A_L_B(L[0])
);   

comp_4 comp1(
    .A(A[7:4]),
    .B(B[7:4]),
    .in_A_G_B(G[0]),
    .in_A_E_B(E[0]),
    .in_A_L_B(L[0]),
    .out_A_G_B(G[1]),
    .out_A_E_B(E[1]),
    .out_A_L_B(L[1])
); 

comp_4 comp2(
    .A(A[11:8]),
    .B(B[11:8]),
    .in_A_G_B(G[1]),
    .in_A_E_B(E[1]),
    .in_A_L_B(L[1]),
    .out_A_G_B(G[2]),
    .out_A_E_B(E[2]),
    .out_A_L_B(L[2])
); 

comp_4 comp3(
    .A(A[15:12]),
    .B(B[15:12]),
    .in_A_G_B(G[2]),
    .in_A_E_B(E[2]),
    .in_A_L_B(L[2]),
    .out_A_G_B(G[3]),
    .out_A_E_B(E[3]),
    .out_A_L_B(L[3])
); 

always @(*)begin
    out_A_G_B=G[3];
    out_A_E_B=E[3];
    out_A_L_B=L[3];
end

endmodule