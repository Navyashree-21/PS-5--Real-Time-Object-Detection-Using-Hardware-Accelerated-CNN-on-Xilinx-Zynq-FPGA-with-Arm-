module cnn_conv_top #(
    parameter IMG_WIDTH = 32
)(
    input               clk,
    input               rst,

    // Input pixel stream
    input       [7:0]   pixel_in,
    input               pixel_valid,

    // Kernel weights (loaded per filter)
    input signed [7:0]  k0, k1, k2,
    input signed [7:0]  k3, k4, k5,
    input signed [7:0]  k6, k7, k8,

    // Output feature stream (after pooling)
    output reg signed [31:0] feature_out,
    output reg              feature_valid
);

    /* ===============================
       LINE BUFFER OUTPUTS
       =============================== */
    wire [7:0] w0, w1, w2;
    wire [7:0] w3, w4, w5;
    wire [7:0] w6, w7, w8;
    wire       window_valid;

    line_buffer #(
        .IMG_WIDTH(IMG_WIDTH)
    ) lb_inst (
        .clk(clk),
        .rst(rst),
        .pixel_in(pixel_in),
        .pixel_valid(pixel_valid),
        .w0(w0), .w1(w1), .w2(w2),
        .w3(w3), .w4(w4), .w5(w5),
        .w6(w6), .w7(w7), .w8(w8),
        .window_valid(window_valid)
    );

    /* ===============================
       CONVOLUTION (MAC)
       =============================== */
    wire signed [31:0] mac_out;

    mac_3x3 mac_inst (
        .p0(w0), .p1(w1), .p2(w2),
        .p3(w3), .p4(w4), .p5(w5),
        .p6(w6), .p7(w7), .p8(w8),
        .w0(k0), .w1(k1), .w2(k2),
        .w3(k3), .w4(k4), .w5(k5),
        .w6(k6), .w7(k7), .w8(k8),
        .mac_out(mac_out)
    );

    /* ===============================
       ACTIVATION (ReLU)
       =============================== */
    wire signed [31:0] relu_out;

    relu_unit relu_inst (
        .in(mac_out),
        .out(relu_out)
    );

    /* ===============================
       POOLING (2x2 MAX POOL)
       =============================== */

    reg signed [31:0] pool_buf [0:3];
    reg [1:0] pool_cnt;
    
    always @(posedge clk) begin
        if (rst) begin
            pool_cnt      <= 0;
            feature_valid <= 0;
        end
        else if (window_valid) begin
            pool_buf[pool_cnt] <= relu_out;
            pool_cnt <= pool_cnt + 1;

            if (pool_cnt == 3) begin
                // Max of 4 values
                feature_out <= pool_buf[0];
                if (pool_buf[1] > feature_out) feature_out <= pool_buf[1];
                if (pool_buf[2] > feature_out) feature_out <= pool_buf[2];
                if (pool_buf[3] > feature_out) feature_out <= pool_buf[3];

                feature_valid <= 1;
                pool_cnt <= 0;
            end
            else begin
                feature_valid <= 0;
            end
        end
        else begin
            feature_valid <= 0;
        end
    end

endmodule
