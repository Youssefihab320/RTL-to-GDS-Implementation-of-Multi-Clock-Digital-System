onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {TB Signals} /uart_tx_top_tb/RST_tb
add wave -noupdate -expand -group {TB Signals} -color Magenta /uart_tx_top_tb/CLK_tb
add wave -noupdate -expand -group {TB Signals} /uart_tx_top_tb/P_DATA_tb
add wave -noupdate -expand -group {TB Signals} /uart_tx_top_tb/Data_Valid_tb
add wave -noupdate -expand -group {TB Signals} /uart_tx_top_tb/PAR_TYP_tb
add wave -noupdate -expand -group {TB Signals} /uart_tx_top_tb/PAR_EN_tb
add wave -noupdate -expand -group {TB Signals} -color Turquoise /uart_tx_top_tb/TX_OUT_tb
add wave -noupdate -expand -group {TB Signals} -color Orange /uart_tx_top_tb/busy_tb
add wave -noupdate -expand -group {TB Signals} /uart_tx_top_tb/data_reg_no_par
add wave -noupdate -expand -group {TB Signals} /uart_tx_top_tb/data_reg_par
add wave -noupdate -expand -group {TB Signals} /uart_tx_top_tb/expected_output_no_par
add wave -noupdate -expand -group {TB Signals} /uart_tx_top_tb/expected_output_par
add wave -noupdate -expand -group {TB Signals} /uart_tx_top_tb/i
add wave -noupdate -expand -group {TB Signals} /uart_tx_top_tb/parity_bit_calc
add wave -noupdate -expand -group {TB Signals} /uart_tx_top_tb/operation_count
add wave -noupdate -expand -group FSM /uart_tx_top_tb/DUT/fsm1/ser_done
add wave -noupdate -expand -group FSM /uart_tx_top_tb/DUT/fsm1/par_en
add wave -noupdate -expand -group FSM /uart_tx_top_tb/DUT/fsm1/ser_en
add wave -noupdate -expand -group FSM /uart_tx_top_tb/DUT/fsm1/mux_sel
add wave -noupdate -expand -group FSM -radixshowbase 0 /uart_tx_top_tb/DUT/fsm1/current_state
add wave -noupdate -expand -group FSM -radixshowbase 0 /uart_tx_top_tb/DUT/fsm1/next_state
add wave -noupdate -expand -group Serializer /uart_tx_top_tb/DUT/s1/bit_count
add wave -noupdate -expand -group Serializer /uart_tx_top_tb/DUT/s1/ser_data
add wave -noupdate -expand -group Serializer /uart_tx_top_tb/DUT/s1/data_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 273
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
WaveRestoreZoom {0 ps} {375900 ps}
