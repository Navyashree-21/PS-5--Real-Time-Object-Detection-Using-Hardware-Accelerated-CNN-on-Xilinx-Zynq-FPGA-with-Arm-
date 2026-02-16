module relu_unit (
    input  signed [31:0] in,
    output signed [31:0] out
);
    assign out = (in < 0) ? 0 : in;
endmodule
