module comp_4(
  input [3:0]A,
  input [3:0]B,
  input in_A_G_B,
  input in_A_E_B,
  input in_A_L_B,
  output reg out_A_G_B,
  output reg out_A_E_B,
  output reg out_A_L_B
);

wire [3:0]T;
xnor(T[0],A[0],B[0]);
xnor(T[1],A[1],B[1]);
xnor(T[2],A[2],B[2]);
xnor(T[3],A[3],B[3]);

always @(*)begin
  out_A_G_B = (A[3] & ~B[3]) | (T[3] & A[2] & ~B[2] ) | (T[3] & T[2] & A[1] & ~B[1]) | (T[3] & T[2] & T[1] & A[0] & ~B[0]) | (T[3] & T[2] & T[1] & T[0] & in_A_G_B);
  out_A_E_B = T[3] & T[2] & T[1] & T[0] & in_A_E_B;
  out_A_L_B = ~(out_A_G_B | out_A_E_B);
end


endmodule
