onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {TB Signals} /SYS_TOP_tb/DATA_WIDTH_tb
add wave -noupdate -expand -group {TB Signals} /SYS_TOP_tb/RF_ADDR_tb
add wave -noupdate -expand -group {TB Signals} /SYS_TOP_tb/REF_CLK_PERIOD
add wave -noupdate -expand -group {TB Signals} /SYS_TOP_tb/UART_CLK_PERIOD
add wave -noupdate -expand -group {TB Signals} /SYS_TOP_tb/PAR_EN_tb
add wave -noupdate -expand -group {TB Signals} /SYS_TOP_tb/PAR_TYP_tb
add wave -noupdate -expand -group {TB Signals} /SYS_TOP_tb/calculated_parity_bit
add wave -noupdate -expand -group {TB Signals} /SYS_TOP_tb/RST_N_tb
add wave -noupdate -expand -group {TB Signals} -color Magenta /SYS_TOP_tb/UART_CLK_tb
add wave -noupdate -expand -group {TB Signals} -color Goldenrod /SYS_TOP_tb/REF_CLK_tb
add wave -noupdate -expand -group {TB Signals} -color {Orange Red} /SYS_TOP_tb/UART_RX_IN_tb
add wave -noupdate -expand -group {TB Signals} -color Cyan /SYS_TOP_tb/UART_TX_O_tb
add wave -noupdate -expand -group {TB Signals} /SYS_TOP_tb/parity_error_tb
add wave -noupdate -expand -group {TB Signals} /SYS_TOP_tb/framing_error_tb
add wave -noupdate -group U0_RST_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_RST_SYNC/NUM_STAGES
add wave -noupdate -group U0_RST_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_RST_SYNC/CLK
add wave -noupdate -group U0_RST_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_RST_SYNC/RST
add wave -noupdate -group U0_RST_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_RST_SYNC/SYNC_RST
add wave -noupdate -group U0_RST_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_RST_SYNC/reset_reg
add wave -noupdate -group U1_RST_SYNC /SYS_TOP_tb/U0_SYS_TOP/U1_RST_SYNC/NUM_STAGES
add wave -noupdate -group U1_RST_SYNC /SYS_TOP_tb/U0_SYS_TOP/U1_RST_SYNC/CLK
add wave -noupdate -group U1_RST_SYNC /SYS_TOP_tb/U0_SYS_TOP/U1_RST_SYNC/RST
add wave -noupdate -group U1_RST_SYNC /SYS_TOP_tb/U0_SYS_TOP/U1_RST_SYNC/SYNC_RST
add wave -noupdate -group U1_RST_SYNC /SYS_TOP_tb/U0_SYS_TOP/U1_RST_SYNC/reset_reg
add wave -noupdate -group U0_DATA_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_ref_sync/NUM_STAGES
add wave -noupdate -group U0_DATA_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_ref_sync/BUS_WIDTH
add wave -noupdate -group U0_DATA_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_ref_sync/Unsync_bus
add wave -noupdate -group U0_DATA_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_ref_sync/bus_enable
add wave -noupdate -group U0_DATA_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_ref_sync/CLK
add wave -noupdate -group U0_DATA_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_ref_sync/RST
add wave -noupdate -group U0_DATA_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_ref_sync/sync_bus
add wave -noupdate -group U0_DATA_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_ref_sync/enable_pulse
add wave -noupdate -group U0_DATA_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_ref_sync/enable_sync_reg
add wave -noupdate -group U0_DATA_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_ref_sync/bus_enable_reg
add wave -noupdate -group U0_DATA_SYNC /SYS_TOP_tb/U0_SYS_TOP/U0_ref_sync/enable_pulse_temp
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/DATA_WIDTH
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/DEPTH
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/ADDR_WIDTH
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/W_CLK
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/W_RST
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/W_INC
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/R_CLK
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/R_RST
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/R_INC
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/WR_DATA
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/FULL
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/EMPTY
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/RD_DATA
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/W_ADDR
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/R_ADDR
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/rptr_in
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/wptr_in
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/rptr_out
add wave -noupdate -expand -group ASYC_FIFO /SYS_TOP_tb/U0_SYS_TOP/U0_UART_FIFO/wptr_out
add wave -noupdate -group PULSE_GEN /SYS_TOP_tb/U0_SYS_TOP/U0_PULSE_GEN/CLK
add wave -noupdate -group PULSE_GEN /SYS_TOP_tb/U0_SYS_TOP/U0_PULSE_GEN/RST
add wave -noupdate -group PULSE_GEN /SYS_TOP_tb/U0_SYS_TOP/U0_PULSE_GEN/LVL_SIG
add wave -noupdate -group PULSE_GEN /SYS_TOP_tb/U0_SYS_TOP/U0_PULSE_GEN/PULSE_SIG
add wave -noupdate -group PULSE_GEN /SYS_TOP_tb/U0_SYS_TOP/U0_PULSE_GEN/ff1
add wave -noupdate -group PULSE_GEN /SYS_TOP_tb/U0_SYS_TOP/U0_PULSE_GEN/ff2
add wave -noupdate -group U0_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U0_ClkDiv/DIV_RATIO_WIDTH
add wave -noupdate -group U0_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U0_ClkDiv/i_ref_clk
add wave -noupdate -group U0_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U0_ClkDiv/i_rst_n
add wave -noupdate -group U0_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U0_ClkDiv/i_clk_en
add wave -noupdate -group U0_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U0_ClkDiv/i_div_ratio
add wave -noupdate -group U0_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U0_ClkDiv/o_div_clk
add wave -noupdate -group U0_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U0_ClkDiv/counter
add wave -noupdate -group U0_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U0_ClkDiv/internal_div_clk
add wave -noupdate -group U0_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U0_ClkDiv/clk_div_en_internal
add wave -noupdate -group U0_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U0_ClkDiv/half_togg
add wave -noupdate -group U0_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U0_ClkDiv/odd
add wave -noupdate -group U0_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U0_ClkDiv/half_togg_odd
add wave -noupdate -group U0_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U0_ClkDiv/flag_odd
add wave -noupdate -group U0_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U0_ClkDiv/temp_div_ratio
add wave -noupdate -group ClkDiv_MUX /SYS_TOP_tb/U0_SYS_TOP/U0_CLKDIV_MUX/WIDTH
add wave -noupdate -group ClkDiv_MUX /SYS_TOP_tb/U0_SYS_TOP/U0_CLKDIV_MUX/IN
add wave -noupdate -group ClkDiv_MUX /SYS_TOP_tb/U0_SYS_TOP/U0_CLKDIV_MUX/OUT
add wave -noupdate -group U1_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U1_ClkDiv/DIV_RATIO_WIDTH
add wave -noupdate -group U1_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U1_ClkDiv/i_ref_clk
add wave -noupdate -group U1_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U1_ClkDiv/i_rst_n
add wave -noupdate -group U1_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U1_ClkDiv/i_clk_en
add wave -noupdate -group U1_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U1_ClkDiv/i_div_ratio
add wave -noupdate -group U1_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U1_ClkDiv/o_div_clk
add wave -noupdate -group U1_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U1_ClkDiv/counter
add wave -noupdate -group U1_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U1_ClkDiv/internal_div_clk
add wave -noupdate -group U1_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U1_ClkDiv/clk_div_en_internal
add wave -noupdate -group U1_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U1_ClkDiv/half_togg
add wave -noupdate -group U1_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U1_ClkDiv/odd
add wave -noupdate -group U1_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U1_ClkDiv/half_togg_odd
add wave -noupdate -group U1_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U1_ClkDiv/flag_odd
add wave -noupdate -group U1_ClkDiv /SYS_TOP_tb/U0_SYS_TOP/U1_ClkDiv/temp_div_ratio
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/DATA_WIDTH
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/RST
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/TX_CLK
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/RX_CLK
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/RX_IN_S
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/RX_OUT_P
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/RX_OUT_V
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/TX_IN_P
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/TX_IN_V
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/TX_OUT_S
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/TX_OUT_V
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/Prescale
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/parity_enable
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/parity_type
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/parity_error
add wave -noupdate -expand -group UART /SYS_TOP_tb/U0_SYS_TOP/U0_UART/framing_error
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/CLK
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/RST
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/ALU_OUT
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/ALU_OUT_Valid
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/RF_RdData
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/RF_RdData_Valid
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/RX_P_DATA
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/RX_D_VLD
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/FIFO_FULL
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/ALU_FUN
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/ALU_EN
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/CLK_EN
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/RF_Address
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/RF_WrEn
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/RF_RdEn
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/RF_WrData
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/TX_P_DATA
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/TX_D_VLD
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/clk_div_en
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/Addr_temp
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/current_state
add wave -noupdate -expand -group SYS_CTRL /SYS_TOP_tb/U0_SYS_TOP/U0_SYS_CTRL/next_state
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/WIDTH
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/DEPTH
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/ADDR
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/CLK
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/RST
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/WrEn
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/RdEn
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/Address
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/WrData
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/RdData
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/RdData_VLD
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/REG0
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/REG1
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/REG2
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/REG3
add wave -noupdate -expand -group RegFile /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/i
add wave -noupdate -expand -group RegFile -expand /SYS_TOP_tb/U0_SYS_TOP/U0_RegFile/regArr
add wave -noupdate -group ALU /SYS_TOP_tb/U0_SYS_TOP/U0_ALU/OPER_WIDTH
add wave -noupdate -group ALU /SYS_TOP_tb/U0_SYS_TOP/U0_ALU/OUT_WIDTH
add wave -noupdate -group ALU /SYS_TOP_tb/U0_SYS_TOP/U0_ALU/FUN_WIDTH
add wave -noupdate -group ALU /SYS_TOP_tb/U0_SYS_TOP/U0_ALU/CLK
add wave -noupdate -group ALU /SYS_TOP_tb/U0_SYS_TOP/U0_ALU/RST
add wave -noupdate -group ALU /SYS_TOP_tb/U0_SYS_TOP/U0_ALU/A
add wave -noupdate -group ALU /SYS_TOP_tb/U0_SYS_TOP/U0_ALU/B
add wave -noupdate -group ALU /SYS_TOP_tb/U0_SYS_TOP/U0_ALU/EN
add wave -noupdate -group ALU /SYS_TOP_tb/U0_SYS_TOP/U0_ALU/ALU_FUN
add wave -noupdate -group ALU /SYS_TOP_tb/U0_SYS_TOP/U0_ALU/ALU_OUT
add wave -noupdate -group ALU /SYS_TOP_tb/U0_SYS_TOP/U0_ALU/OUT_VALID
add wave -noupdate -group ALU /SYS_TOP_tb/U0_SYS_TOP/U0_ALU/ALU_OUT_Comb
add wave -noupdate -group ALU /SYS_TOP_tb/U0_SYS_TOP/U0_ALU/OUT_VALID_Comb
add wave -noupdate -group ClkGate /SYS_TOP_tb/U0_SYS_TOP/U0_CLK_GATE/CLK
add wave -noupdate -group ClkGate /SYS_TOP_tb/U0_SYS_TOP/U0_CLK_GATE/CLK_EN
add wave -noupdate -group ClkGate /SYS_TOP_tb/U0_SYS_TOP/U0_CLK_GATE/GATED_CLK
add wave -noupdate -group ClkGate /SYS_TOP_tb/U0_SYS_TOP/U0_CLK_GATE/latched_en
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/DATA_WIDTH
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/start_bit
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/stop_bit
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/P_DATA
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/RST
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/CLK
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/Data_Valid
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/PAR_TYP
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/PAR_EN
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/TX_OUT
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/busy
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/ser_en
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/ser_done
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/par_bit
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/ser_data
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/mux_sel
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/fsm1/clk
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/fsm1/reset
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/fsm1/data_valid
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/fsm1/ser_done
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/fsm1/par_en
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/fsm1/ser_en
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/fsm1/busy
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/fsm1/mux_sel
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/fsm1/current_state
add wave -noupdate -group {UART TX} /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/fsm1/next_state
add wave -noupdate -group TX_SER /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/s1/DATA_WIDTH
add wave -noupdate -group TX_SER /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/s1/p_data
add wave -noupdate -group TX_SER /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/s1/ser_en
add wave -noupdate -group TX_SER /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/s1/clk
add wave -noupdate -group TX_SER /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/s1/reset
add wave -noupdate -group TX_SER /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/s1/busy
add wave -noupdate -group TX_SER /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/s1/data_valid
add wave -noupdate -group TX_SER /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/s1/ser_done
add wave -noupdate -group TX_SER /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/s1/ser_data
add wave -noupdate -group TX_SER /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/s1/data_reg
add wave -noupdate -group TX_SER /SYS_TOP_tb/U0_SYS_TOP/U0_UART/U0_UART_TX/s1/bit_count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {697386334 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 179
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1787161252 ps}
