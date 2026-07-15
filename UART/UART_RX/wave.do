onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {TB Signals} /UART_RX_tb/RST_tb
add wave -noupdate -expand -group {TB Signals} -color Magenta /UART_RX_tb/CLK_tb
add wave -noupdate -expand -group {TB Signals} /UART_RX_tb/TX_CLK
add wave -noupdate -expand -group {TB Signals} -color Cyan /UART_RX_tb/RX_IN_tb
add wave -noupdate -expand -group {TB Signals} /UART_RX_tb/Prescale_tb
add wave -noupdate -expand -group {TB Signals} /UART_RX_tb/PAR_EN_tb
add wave -noupdate -expand -group {TB Signals} /UART_RX_tb/PAR_TYP_tb
add wave -noupdate -expand -group {TB Signals} -color {Orange Red} /UART_RX_tb/data_valid_tb
add wave -noupdate -expand -group {TB Signals} -color {Slate Blue} /UART_RX_tb/P_DATA_tb
add wave -noupdate -expand -group {TB Signals} /UART_RX_tb/operation_count
add wave -noupdate -expand -group {TB Signals} -color Pink /UART_RX_tb/Parity_Error_tb
add wave -noupdate -expand -group {TB Signals} -color {Medium Orchid} /UART_RX_tb/Stop_Error_tb
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/fsm1/edge_cnt
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/fsm1/bit_cnt
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/fsm1/par_err
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/fsm1/strt_glitch
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/fsm1/stp_err
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/fsm1/enable
add wave -noupdate -expand -group FSM -color Yellow /UART_RX_tb/DUT/fsm1/data_samp_en
add wave -noupdate -expand -group FSM -color Magenta /UART_RX_tb/DUT/fsm1/par_chk_en
add wave -noupdate -expand -group FSM -color Goldenrod /UART_RX_tb/DUT/fsm1/strt_chk_en
add wave -noupdate -expand -group FSM -color {Sky Blue} /UART_RX_tb/DUT/fsm1/stp_chk_en
add wave -noupdate -expand -group FSM -color Brown /UART_RX_tb/DUT/fsm1/deser_en
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/fsm1/current_state
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/fsm1/next_state
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/fsm1/frame_size
add wave -noupdate -expand -group Parity /UART_RX_tb/DUT/pc1/par_bit
add wave -noupdate -expand -group Data_Sampling /UART_RX_tb/DUT/ds1/sample_1
add wave -noupdate -expand -group Data_Sampling /UART_RX_tb/DUT/ds1/sample_2
add wave -noupdate -expand -group Data_Sampling /UART_RX_tb/DUT/ds1/sample_3
add wave -noupdate -expand -group Data_Sampling /UART_RX_tb/DUT/ds1/sampled_bit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2015930 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 239
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ns} {2216981 ns}
