module add_4(
    input [3:0] in_0,
    input [3:0] in_1,
    input c_in,
    output [3:0] out,
    output cout
);
    
    assign{cout, out}=in_0+in_1+c_in;
    
endmodule
