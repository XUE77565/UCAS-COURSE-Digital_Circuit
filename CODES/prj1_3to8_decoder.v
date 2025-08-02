module decoder1(
    input [2:0]in,
    input state,
    output reg[7:0]out
);

    always @(state or in)begin
    if(state)begin
        case(in)
        3'b000: out=8'b11111110;
        3'b001: out=8'b11111101;
        3'b010: out=8'b11111011;
        3'b011: out=8'b11110111;
        3'b100: out=8'b11101111;
        3'b101: out=8'b11011111;
        3'b110: out=8'b10111111;
        3'b111: out=8'b01111111;
        default out=8'b11111111;
        endcase
    end
    else begin
        out=8'bZZZZZZZZ;
    end
end

endmodule
