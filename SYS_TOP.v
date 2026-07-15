module SYS_TOP #( 
    parameter DATA_WIDTH = 8 ,  RF_ADDR = 4 
)(
    input wire RST_N,                   // Active Low Reset of the system
    input wire UART_CLK,                // UART Clock
    input wire REF_CLK,                 // REF Clock (RegFile, SYS_CTRL, ASYC FIFO)
    input wire UART_RX_IN,              // UART RX IN (Serial)
    output wire UART_TX_O,              // UART TX OUT (Serial)
    output wire parity_error,           // Parity error Flag
    output wire framing_error           // Stop error Flag
);

// Internal Connections
wire SYNC_UART_RST, SYNC_REF_RST;
									   
wire UART_TX_CLK;
wire UART_RX_CLK;


wire [DATA_WIDTH-1:0] Operand_A, Operand_B, UART_Config, DIV_RATIO;
									   
wire [DATA_WIDTH-1:0] DIV_RATIO_RX;
									   
wire [DATA_WIDTH-1:0] UART_RX_OUT;
wire UART_RX_V_OUT;
wire [DATA_WIDTH-1:0] UART_RX_SYNC;
wire UART_RX_V_SYNC;

wire [DATA_WIDTH-1:0] UART_TX_IN;
wire UART_TX_VLD;
wire [DATA_WIDTH-1:0] UART_TX_SYNC;
wire UART_TX_V_SYNC;

wire UART_TX_Busy;	
wire UART_TX_Busy_PULSE;	
									   
wire RF_WrEn;
wire RF_RdEn;
wire [RF_ADDR-1:0] RF_Address;
wire [DATA_WIDTH-1:0] RF_WrData;
wire [DATA_WIDTH-1:0] RF_RdData;
wire RF_RdData_VLD;									   

wire CLKG_EN;
wire ALU_EN;
wire [3:0] ALU_FUN; 
wire [DATA_WIDTH*2-1:0] ALU_OUT;
wire ALU_OUT_VLD; 
									   
wire ALU_CLK ;								   

wire FIFO_FULL ;
	
wire CLKDIV_EN ;

// Instantiate the Design Modules			   
// Two Reset SYNC
RST_SYNC # (.NUM_STAGES(2)) U0_RST_SYNC (
.RST(RST_N),
.CLK(UART_CLK),
.SYNC_RST(SYNC_UART_RST)
);

RST_SYNC # (.NUM_STAGES(2)) U1_RST_SYNC (
.RST(RST_N),
.CLK(REF_CLK),
.SYNC_RST(SYNC_REF_RST)
);

// DATA SYNC
DATA_SYNC # (.NUM_STAGES(2) , .BUS_WIDTH(8)) U0_ref_sync (
.CLK(REF_CLK),
.RST(SYNC_REF_RST),
.Unsync_bus(UART_RX_OUT),
.bus_enable(UART_RX_V_OUT),
.sync_bus(UART_RX_SYNC),
.enable_pulse(UART_RX_V_SYNC)
);


// Async FIFO
ASYC_FIFO_Top #(.DATA_WIDTH(DATA_WIDTH) , .DEPTH(8)  , .ADDR_WIDTH(3)) U0_UART_FIFO (
.W_CLK(REF_CLK),
.W_RST(SYNC_REF_RST),  
.W_INC(UART_TX_VLD),
.WR_DATA(UART_TX_IN),             
.R_CLK(UART_TX_CLK),              
.R_RST(SYNC_UART_RST),              
.R_INC(UART_TX_Busy_PULSE),              
.RD_DATA(UART_TX_SYNC),             
.FULL(FIFO_FULL),               
.EMPTY(UART_TX_V_SYNC)               
);

// Pulse Gen
PULSE_GEN U0_PULSE_GEN (
.CLK(UART_TX_CLK),
.RST(SYNC_UART_RST),
.LVL_SIG(UART_TX_Busy),
.PULSE_SIG(UART_TX_Busy_PULSE)
);

// CLK DIV for UART TX
ClkDiv #(
.DIV_RATIO_WIDTH(8)
) U0_ClkDiv (
.i_ref_clk(UART_CLK),             
.i_rst_n(SYNC_UART_RST),                 
.i_clk_en(CLKDIV_EN),               
.i_div_ratio(DIV_RATIO),           
.o_div_clk(UART_TX_CLK)             
);

// Clock Mux
CLKDIV_MUX #(
.WIDTH(8)
) U0_CLKDIV_MUX (
.IN(UART_Config[7:2]),
.OUT(DIV_RATIO_RX)
);

// CLK DIV for UART RX
ClkDiv #(
.DIV_RATIO_WIDTH(8)
) U1_ClkDiv (
.i_ref_clk(UART_CLK),             
.i_rst_n(SYNC_UART_RST),                 
.i_clk_en(CLKDIV_EN),               
.i_div_ratio(DIV_RATIO_RX),           
.o_div_clk(UART_RX_CLK)             
);

// UART
UART  U0_UART (
.RST(SYNC_UART_RST),
.TX_CLK(UART_TX_CLK),
.RX_CLK(UART_RX_CLK),
.parity_enable(UART_Config[0]),
.parity_type(UART_Config[1]),
.Prescale(UART_Config[7:2]),
.RX_IN_S(UART_RX_IN),
.RX_OUT_P(UART_RX_OUT),                      
.RX_OUT_V(UART_RX_V_OUT),                      
.TX_IN_P(UART_TX_SYNC), 
.TX_IN_V(!UART_TX_V_SYNC), 
.TX_OUT_S(UART_TX_O),
.TX_OUT_V(UART_TX_Busy),
.parity_error(parity_error),
.framing_error(framing_error)                  
);

// SYS_CTRL
SYS_CTRL U0_SYS_CTRL (
.CLK(REF_CLK),
.RST(SYNC_REF_RST),
.RF_RdData(RF_RdData),
.RF_RdData_Valid(RF_RdData_VLD),
.RF_WrEn(RF_WrEn),
.RF_RdEn(RF_RdEn),
.RF_Address(RF_Address),
.RF_WrData(RF_WrData),
.ALU_EN(ALU_EN),
.ALU_FUN(ALU_FUN), 
.ALU_OUT(ALU_OUT),
.ALU_OUT_Valid(ALU_OUT_VLD),  
.CLK_EN(CLKG_EN), 
.clk_div_en(CLKDIV_EN),   
.FIFO_FULL(FIFO_FULL),
.RX_P_DATA(UART_RX_SYNC), 
.RX_D_VLD(UART_RX_V_SYNC),
.TX_P_DATA(UART_TX_IN), 
.TX_D_VLD(UART_TX_VLD)
);

// RegFile
RegFile #(
.WIDTH(8),
.DEPTH(16),
.ADDR(4)    
) U0_RegFile (
.CLK(REF_CLK),
.RST(SYNC_REF_RST),
.WrEn(RF_WrEn),
.RdEn(RF_RdEn),
.Address(RF_Address),
.WrData(RF_WrData),
.RdData(RF_RdData),
.RdData_VLD(RF_RdData_VLD),
.REG0(Operand_A),
.REG1(Operand_B),
.REG2(UART_Config),
.REG3(DIV_RATIO)
);

// ALU
ALU #(
.OPER_WIDTH(8),
.FUN_WIDTH(4)
) U0_ALU (
.CLK(ALU_CLK),
.RST(SYNC_REF_RST),  
.A(Operand_A), 
.B(Operand_B),
.EN(ALU_EN),
.ALU_FUN(ALU_FUN),
.ALU_OUT(ALU_OUT),
.OUT_VALID(ALU_OUT_VLD)
);


// Clock Gating
CLK_GATE U0_CLK_GATE (
.CLK_EN(CLKG_EN),
.CLK(REF_CLK),
.GATED_CLK(ALU_CLK)
);

endmodule
 