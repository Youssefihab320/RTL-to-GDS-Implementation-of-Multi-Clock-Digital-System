module UART_RX #(
    parameter DATA_WIDTH = 8
)(
    // Inputs
    input wire CLK,
    input wire RST,
    input wire RX_IN,
    input wire [5:0] Prescale,
    input wire PAR_EN,
    input wire PAR_TYP,

    // Outputs 
    output wire data_valid,
    output wire [7:0] P_DATA,
    output wire Parity_Error,
    output wire Stop_Error
);

// Internal Wires
wire enable;
wire [4:0] edge_cnt; 
wire [3:0] bit_cnt;
wire data_samp_en;
wire sampled_bit;
wire par_chk_en;
wire strt_chk_en;
wire strt_glitch;
wire stp_chk_en;
wire deser_en;

// Instantiating the Submodules
edge_bit_counter ebc1 (
                        .clk(CLK),
                        .reset(RST),
                        .enable(enable),
                        .par_en(PAR_EN),
                        .prescale(Prescale),
                        .edge_cnt(edge_cnt),
                        .bit_cnt(bit_cnt)
);

data_sampling ds1 (
                    .clk(CLK),
                    .reset(RST),
                    .RX_IN(RX_IN),
                    .data_samp_en(data_samp_en),
                    .edge_cnt(edge_cnt),
                    .prescale(Prescale),
                    .sampled_bit(sampled_bit)
);

parity_check #(
                    .DATA_WIDTH(DATA_WIDTH)
) pc1 (
                    .clk(CLK),
                    .reset(RST),
                    .P_DATA(P_DATA),
                    .par_en(PAR_EN),
                    .par_typ(PAR_TYP),
                    .par_chk_en(par_chk_en),
                    .sampled_bit(sampled_bit),
                    .bit_cnt(bit_cnt),
                    .par_err(Parity_Error)
);

strt_check sc1 (
                    .clk(CLK),
                    .reset(RST),
                    .strt_chk_en(strt_chk_en),
                    .sampled_bit(sampled_bit),
                    .bit_cnt(bit_cnt),
                    .strt_glitch(strt_glitch)
);

stop_check sc2 (
                    .clk(CLK),
                    .reset(RST),
                    .stp_chk_en(stp_chk_en),
                    .sampled_bit(sampled_bit),
                    .bit_cnt(bit_cnt),
                    .stp_err(Stop_Error)
);

deserializer #(
                    .DATA_WIDTH(DATA_WIDTH)
) d1 (
                    .clk(CLK),
                    .reset(RST),
                    .sampled_bit(sampled_bit),
                    .deser_en(deser_en),
                    .P_DATA(P_DATA)
);

rx_fsm fsm1 (
                    .clk(CLK),
                    .reset(RST),
                    .par_en(PAR_EN),
                    .RX_IN(RX_IN),
                    .edge_cnt(edge_cnt),
                    .bit_cnt(bit_cnt),
                    .par_err(Parity_Error),
                    .strt_glitch(strt_glitch),
                    .stp_err(Stop_Error),
                    .Prescale(Prescale),
                    .enable(enable),
                    .data_samp_en(data_samp_en),
                    .par_chk_en(par_chk_en),
                    .strt_chk_en(strt_chk_en),
                    .stp_chk_en(stp_chk_en),
                    .deser_en(deser_en),
                    .data_valid(data_valid)
);

endmodule