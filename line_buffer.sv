module line_buffer #(
    parameter IMG_WIDTH = 32
)(
    input               clk,
    input               rst,
    input       [7:0]   pixel_in,
    input               pixel_valid,
    output reg  [7:0]   w0, w1, w2,
    output reg  [7:0]   w3, w4, w5,
    output reg  [7:0]   w6, w7, w8,
    output reg          window_valid
);

    reg [7:0] row0 [0:IMG_WIDTH-1];
    reg [7:0] row1 [0:IMG_WIDTH-1];
    reg [7:0] row2 [0:IMG_WIDTH-1];

    integer i;
    reg [5:0] col_cnt;
    reg [5:0] row_cnt;

    always @(posedge clk) begin
        if (rst) begin
            col_cnt <= 0;
            row_cnt <= 0;
            window_valid <= 0;
        end else if (pixel_valid) begin

            // shift rows
            row0[col_cnt] <= row1[col_cnt];
            row1[col_cnt] <= row2[col_cnt];
            row2[col_cnt] <= pixel_in;

            if (col_cnt >= 2 && row_cnt >= 2) begin
                w0 <= row0[col_cnt-2];
                w1 <= row0[col_cnt-1];
                w2 <= row0[col_cnt];

                w3 <= row1[col_cnt-2];
                w4 <= row1[col_cnt-1];
                w5 <= row1[col_cnt];

                w6 <= row2[col_cnt-2];
                w7 <= row2[col_cnt-1];
                w8 <= row2[col_cnt];

                window_valid <= 1;
            end else begin
                window_valid <= 0;
            end

            if (col_cnt == IMG_WIDTH-1) begin
                col_cnt <= 0;
                row_cnt <= row_cnt + 1;
            end else begin
                col_cnt <= col_cnt + 1;
            end
        end
    end
endmodule
