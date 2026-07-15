module UART_TX #(
    parameter DATA_WIDTH = 8
)(
    // Inputs
    input wire [DATA_WIDTH - 1 : 0] P_DATA,
    input wire RST,
    input wire CLK,
    input wire Data_Valid,
    input wire PAR_TYP,
    input wire PAR_EN,

    // Outputs
    output wire TX_OUT,
    output wire busy
);

// Localparam (Start & Stop bits)
localparam start_bit = 1'b0;
localparam stop_bit = 1'b1;

// Internal Wires
wire ser_en;
wire ser_done;
wire par_bit;
wire ser_data;
wire [1:0] mux_sel;
    
// Instantiating Sub-modules
serializer #(
                .DATA_WIDTH(DATA_WIDTH)
) s1 (
                .p_data(P_DATA),
                .ser_en(ser_en),
                .clk(CLK),
                .reset(RST),
                .busy(busy),
                .data_valid(Data_Valid),
                .ser_done(ser_done),
                .ser_data(ser_data)
);

parity_calc #(
                .DATA_WIDTH(DATA_WIDTH)
) p1 (
                .p_data(P_DATA),
                .data_valid(Data_Valid),
                .par_typ(PAR_TYP),
                .busy(busy),
                .reset(RST),
                .clk(CLK),
                .par_bit(par_bit)
);

uart_fsm fsm1 (
                .clk(CLK),
                .reset(RST),
                .data_valid(Data_Valid),
                .ser_done(ser_done),
                .par_en(PAR_EN),
                .ser_en(ser_en),
                .busy(busy),
                .mux_sel(mux_sel)
);

mux m1 (
                .mux_sel(mux_sel),
                .start_bit(start_bit),
                .stop_bit(stop_bit),
                .ser_data(ser_data),
                .par_bit(par_bit),
                .TX_OUT(TX_OUT)
);

endmodule