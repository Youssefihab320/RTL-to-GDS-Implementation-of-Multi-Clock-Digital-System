module ASYC_FIFO_Top #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 8,
    parameter ADDR_WIDTH = 3
) (
    // Inputs
    input wire W_CLK,                           // Write Clock
    input wire W_RST,                           // Write Reset
    input wire W_INC,                           // Write Increment
    input wire R_CLK,                           // Read Clock
    input wire R_RST,                           // Read Reset
    input wire R_INC,                           // Read Increment
    input wire [DATA_WIDTH - 1 : 0] WR_DATA,    // Write Data (Input)

    // Outputs
    output wire FULL,                           // Full Flag
    output wire EMPTY,                          // Empty Flag
    output wire [DATA_WIDTH - 1 : 0] RD_DATA    // Read Data (Output)
);
// Internal Wires
wire [ADDR_WIDTH - 1 : 0] W_ADDR, R_ADDR; 
wire [ADDR_WIDTH : 0] rptr_in, wptr_in;
wire [ADDR_WIDTH : 0] rptr_out, wptr_out;


// Instantiating the Design
fifo_mem #(
            .DATA_WIDTH(DATA_WIDTH),
            .DEPTH(DEPTH),
            .ADDR_WIDTH(ADDR_WIDTH)
) mem (
            .w_clk(W_CLK),
            .w_rst(W_RST),
            .FULL(FULL),
            .w_inc(W_INC),
            .w_addr(W_ADDR),
            .r_addr(R_ADDR),
            .w_data(WR_DATA),
            .r_data(RD_DATA)
);

df_sync #(
            .ADDR_WIDTH(ADDR_WIDTH)
) df1_w (
            .clk(W_CLK),
            .rst(W_RST),
            .data_in(rptr_in),
            .data_out(rptr_out)
);

df_sync #(
            .ADDR_WIDTH(ADDR_WIDTH)
) df2_r (
            .clk(R_CLK),
            .rst(R_RST),
            .data_in(wptr_in),
            .data_out(wptr_out)
);

FIFO_Write #(
            .ADDR_WIDTH(ADDR_WIDTH)
) WR (
            .w_inc(W_INC),
            .w_clk(W_CLK),
            .w_rst(W_RST),
            .gray_rptr(rptr_out),
            .gray_wptr(wptr_in),
            .w_addr(W_ADDR),
            .FULL(FULL)
);

FIFO_Read #(
            .ADDR_WIDTH(ADDR_WIDTH)
) RD (
            .r_clk(R_CLK),
            .r_rst(R_RST),
            .r_inc(R_INC),
            .gray_wptr(wptr_out),
            .gray_rptr(rptr_in),
            .r_addr(R_ADDR),
            .EMPTY(EMPTY)
);

endmodule
