/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Sun Sep  7 20:03:08 2025
/////////////////////////////////////////////////////////////


module serializer ( p_data, ser_en, clk, reset, busy, data_valid, ser_done, 
        ser_data );
  input [7:0] p_data;
  input ser_en, clk, reset, busy, data_valid;
  output ser_done, ser_data;
  wire   N3, N4, N5, N18, N20, N22, n1, n3, n4, n5, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n2, n6, n16, n17, n18, n19;
  wire   [7:0] data_reg;
  assign ser_done = N22;

  DFFRX1M \bit_count_reg[2]  ( .D(N20), .CK(clk), .RN(reset), .Q(N5), .QN(n15)
         );
  DFFRQX1M \data_reg_reg[7]  ( .D(n14), .CK(clk), .RN(reset), .Q(data_reg[7])
         );
  DFFRQX1M \data_reg_reg[6]  ( .D(n13), .CK(clk), .RN(reset), .Q(data_reg[6])
         );
  DFFRQX1M \data_reg_reg[5]  ( .D(n12), .CK(clk), .RN(reset), .Q(data_reg[5])
         );
  DFFRQX1M \data_reg_reg[4]  ( .D(n11), .CK(clk), .RN(reset), .Q(data_reg[4])
         );
  DFFRQX1M \data_reg_reg[3]  ( .D(n10), .CK(clk), .RN(reset), .Q(data_reg[3])
         );
  DFFRQX1M \data_reg_reg[2]  ( .D(n9), .CK(clk), .RN(reset), .Q(data_reg[2])
         );
  DFFRQX1M \data_reg_reg[1]  ( .D(n8), .CK(clk), .RN(reset), .Q(data_reg[1])
         );
  DFFRQX1M \data_reg_reg[0]  ( .D(n7), .CK(clk), .RN(reset), .Q(data_reg[0])
         );
  DFFRX2M \bit_count_reg[1]  ( .D(n17), .CK(clk), .RN(reset), .Q(N4) );
  DFFRQX4M \bit_count_reg[0]  ( .D(N18), .CK(clk), .RN(reset), .Q(N3) );
  OAI211X1M U3 ( .A0(N3), .A1(N4), .B0(n18), .C0(n3), .Y(n5) );
  MX4XLM U4 ( .A(data_reg[0]), .B(data_reg[1]), .C(data_reg[2]), .D(
        data_reg[3]), .S0(N3), .S1(N4), .Y(n16) );
  MX4XLM U5 ( .A(data_reg[4]), .B(data_reg[5]), .C(data_reg[6]), .D(
        data_reg[7]), .S0(N3), .S1(N4), .Y(n6) );
  BUFX4M U6 ( .A(n1), .Y(n2) );
  INVX4M U7 ( .A(n2), .Y(n19) );
  NAND2BX1M U8 ( .AN(busy), .B(data_valid), .Y(n1) );
  NAND2BX2M U9 ( .AN(N22), .B(ser_en), .Y(n4) );
  MX2X2M U10 ( .A(n16), .B(n6), .S0(N5), .Y(ser_data) );
  AO22X1M U11 ( .A0(data_reg[6]), .A1(n2), .B0(p_data[6]), .B1(n19), .Y(n13)
         );
  AO22X1M U12 ( .A0(data_reg[2]), .A1(n2), .B0(p_data[2]), .B1(n19), .Y(n9) );
  AO22X1M U13 ( .A0(data_reg[3]), .A1(n2), .B0(p_data[3]), .B1(n19), .Y(n10)
         );
  AO22X1M U14 ( .A0(data_reg[7]), .A1(n2), .B0(p_data[7]), .B1(n19), .Y(n14)
         );
  AO22X1M U15 ( .A0(data_reg[0]), .A1(n2), .B0(p_data[0]), .B1(n19), .Y(n7) );
  AO22X1M U16 ( .A0(data_reg[4]), .A1(n2), .B0(p_data[4]), .B1(n19), .Y(n11)
         );
  AO22X1M U17 ( .A0(data_reg[1]), .A1(n2), .B0(p_data[1]), .B1(n19), .Y(n8) );
  AO22X1M U18 ( .A0(data_reg[5]), .A1(n2), .B0(p_data[5]), .B1(n19), .Y(n12)
         );
  NOR2X4M U19 ( .A(n3), .B(n15), .Y(N22) );
  INVX2M U20 ( .A(n5), .Y(n17) );
  INVX2M U21 ( .A(n4), .Y(n18) );
  NAND2X2M U22 ( .A(N4), .B(N3), .Y(n3) );
  AOI21X2M U23 ( .A0(n15), .A1(n3), .B0(n4), .Y(N20) );
  NOR2X2M U24 ( .A(N3), .B(n4), .Y(N18) );
endmodule


module parity_calc ( p_data, data_valid, par_typ, busy, reset, clk, par_bit );
  input [7:0] p_data;
  input data_valid, par_typ, busy, reset, clk;
  output par_bit;
  wire   n1, n2, n3, n4, n5, n6, n7;

  DFFRQX1M par_bit_reg ( .D(n7), .CK(clk), .RN(reset), .Q(par_bit) );
  XOR3XLM U2 ( .A(p_data[5]), .B(p_data[4]), .C(n6), .Y(n3) );
  CLKXOR2X2M U3 ( .A(p_data[7]), .B(p_data[6]), .Y(n6) );
  XNOR2X2M U4 ( .A(p_data[3]), .B(p_data[2]), .Y(n5) );
  OAI2BB2X1M U5 ( .B0(n1), .B1(n2), .A0N(par_bit), .A1N(n2), .Y(n7) );
  NAND2BX1M U6 ( .AN(busy), .B(data_valid), .Y(n2) );
  XOR3XLM U7 ( .A(n3), .B(par_typ), .C(n4), .Y(n1) );
  XOR3XLM U8 ( .A(p_data[1]), .B(p_data[0]), .C(n5), .Y(n4) );
endmodule


module uart_fsm ( clk, reset, data_valid, ser_done, par_en, ser_en, busy, 
        mux_sel );
  output [1:0] mux_sel;
  input clk, reset, data_valid, ser_done, par_en;
  output ser_en, busy;
  wire   n8, n4, n5, n6, n2, n3, n7;
  wire   [2:0] current_state;
  wire   [2:0] next_state;

  DFFRX2M \current_state_reg[1]  ( .D(next_state[1]), .CK(clk), .RN(reset), 
        .Q(current_state[1]), .QN(n3) );
  DFFRX2M \current_state_reg[0]  ( .D(next_state[0]), .CK(clk), .RN(reset), 
        .Q(current_state[0]), .QN(n2) );
  DFFRX2M \current_state_reg[2]  ( .D(next_state[2]), .CK(clk), .RN(reset), 
        .Q(current_state[2]), .QN(n7) );
  NAND2X4M U3 ( .A(current_state[0]), .B(n7), .Y(mux_sel[1]) );
  CLKXOR2X2M U4 ( .A(n2), .B(n3), .Y(n5) );
  NOR3X4M U5 ( .A(n2), .B(current_state[2]), .C(n3), .Y(ser_en) );
  NOR3X2M U6 ( .A(n3), .B(current_state[2]), .C(n4), .Y(next_state[2]) );
  BUFX10M U7 ( .A(n8), .Y(busy) );
  OAI21X2M U8 ( .A0(current_state[0]), .A1(n3), .B0(mux_sel[1]), .Y(n8) );
  NAND2X2M U9 ( .A(n5), .B(n7), .Y(mux_sel[0]) );
  AO21XLM U10 ( .A0(n7), .A1(n5), .B0(ser_en), .Y(next_state[1]) );
  OAI22X1M U11 ( .A0(ser_done), .A1(mux_sel[1]), .B0(current_state[1]), .B1(n6), .Y(next_state[0]) );
  AOI21BX2M U12 ( .A0(data_valid), .A1(n7), .B0N(mux_sel[1]), .Y(n6) );
  AOI2B1X1M U13 ( .A1N(par_en), .A0(ser_done), .B0(n2), .Y(n4) );
endmodule


module mux ( mux_sel, start_bit, stop_bit, ser_data, par_bit, TX_OUT );
  input [1:0] mux_sel;
  input start_bit, stop_bit, ser_data, par_bit;
  output TX_OUT;
  wire   n5, n2, n3, n4;

  CLKBUFX8M U1 ( .A(n5), .Y(TX_OUT) );
  OAI2B2X1M U2 ( .A1N(mux_sel[1]), .A0(n2), .B0(mux_sel[1]), .B1(n3), .Y(n5)
         );
  INVX2M U3 ( .A(mux_sel[0]), .Y(n4) );
  AOI22X1M U4 ( .A0(start_bit), .A1(n4), .B0(ser_data), .B1(mux_sel[0]), .Y(n3) );
  AOI22X1M U5 ( .A0(par_bit), .A1(n4), .B0(stop_bit), .B1(mux_sel[0]), .Y(n2)
         );
endmodule


module uart_tx_top ( P_DATA, RST, CLK, Data_Valid, PAR_TYP, PAR_EN, TX_OUT, 
        busy );
  input [7:0] P_DATA;
  input RST, CLK, Data_Valid, PAR_TYP, PAR_EN;
  output TX_OUT, busy;
  wire   ser_en, ser_done, ser_data, par_bit;
  wire   [1:0] mux_sel;

  serializer s1 ( .p_data(P_DATA), .ser_en(ser_en), .clk(CLK), .reset(RST), 
        .busy(busy), .data_valid(Data_Valid), .ser_done(ser_done), .ser_data(
        ser_data) );
  parity_calc p1 ( .p_data(P_DATA), .data_valid(Data_Valid), .par_typ(PAR_TYP), 
        .busy(busy), .reset(RST), .clk(CLK), .par_bit(par_bit) );
  uart_fsm fsm1 ( .clk(CLK), .reset(RST), .data_valid(Data_Valid), .ser_done(
        ser_done), .par_en(PAR_EN), .ser_en(ser_en), .busy(busy), .mux_sel(
        mux_sel) );
  mux m1 ( .mux_sel(mux_sel), .start_bit(1'b0), .stop_bit(1'b1), .ser_data(
        ser_data), .par_bit(par_bit), .TX_OUT(TX_OUT) );
endmodule

