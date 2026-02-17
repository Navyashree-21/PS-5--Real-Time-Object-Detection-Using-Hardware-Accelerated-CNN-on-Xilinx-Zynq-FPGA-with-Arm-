module maxpool_2x2 (
    input               clk,
    input               rst,
    input               valid_in,
    input       signed [31:0] d0, d1, d2, d3,
    output reg          valid_out,
    output reg  signed [31:0] pool_out
);

    always @(posedge clk) begin
        if (rst) begin
            valid_out <= 0;
        end else if (valid_in) begin
            pool_out <= (d0 > d1 ? d0 : d1);
            pool_out <= (pool_out > d2 ? pool_out : d2);
            pool_out <= (pool_out > d3 ? pool_out : d3);
            valid_out <= 1;
        end else begin
            valid_out <= 0;
        end
    end
endmodule
