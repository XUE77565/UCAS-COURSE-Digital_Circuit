module add_1(
    input in_0,
    input in_1,
    input cin,
    output cout,
    output s
);

    wire x1;
    xor(w1,in_0,in_1);
    xor(s,w1,cin);
    wire y1,y2,y3;
    and(y1,w1,cin);
    and(y2,in_0,in_1);
    and(y3,y2,cin);
    or(cout,y3,y1);
    
endmodule
