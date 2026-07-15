onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {TB Signals} /ASYC_FIFO_tb/W_RST_tb
add wave -noupdate -expand -group {TB Signals} /ASYC_FIFO_tb/R_RST_tb
add wave -noupdate -expand -group {TB Signals} -color Magenta /ASYC_FIFO_tb/W_CLK_tb
add wave -noupdate -expand -group {TB Signals} -color {Cornflower Blue} /ASYC_FIFO_tb/R_CLK_tb
add wave -noupdate -expand -group {TB Signals} -color Goldenrod /ASYC_FIFO_tb/W_INC_tb
add wave -noupdate -expand -group {TB Signals} -color {Medium Orchid} /ASYC_FIFO_tb/R_INC_tb
add wave -noupdate -expand -group {TB Signals} /ASYC_FIFO_tb/WR_DATA_tb
add wave -noupdate -expand -group {TB Signals} /ASYC_FIFO_tb/RD_DATA_tb
add wave -noupdate -expand -group {TB Signals} -color {Violet Red} /ASYC_FIFO_tb/FULL_tb
add wave -noupdate -expand -group {TB Signals} -color Gold /ASYC_FIFO_tb/EMPTY_tb
add wave -noupdate -group Parameters /ASYC_FIFO_tb/DATA_WIDTH_tb
add wave -noupdate -group Parameters /ASYC_FIFO_tb/DEPTH_tb
add wave -noupdate -group Parameters /ASYC_FIFO_tb/ADDR_WIDTH_tb
add wave -noupdate -group Parameters /ASYC_FIFO_tb/W_CLK_PERIOD
add wave -noupdate -group Parameters /ASYC_FIFO_tb/R_CLK_PERIOD
add wave -noupdate -expand -group df_w /ASYC_FIFO_tb/DUT/df1_w/clk
add wave -noupdate -expand -group df_w /ASYC_FIFO_tb/DUT/df1_w/data_in
add wave -noupdate -expand -group df_w /ASYC_FIFO_tb/DUT/df1_w/data_out
add wave -noupdate -expand -group df_w /ASYC_FIFO_tb/DUT/df1_w/ff1
add wave -noupdate -expand -group df_r /ASYC_FIFO_tb/DUT/df2_r/clk
add wave -noupdate -expand -group df_r /ASYC_FIFO_tb/DUT/df2_r/data_in
add wave -noupdate -expand -group df_r /ASYC_FIFO_tb/DUT/df2_r/data_out
add wave -noupdate -expand -group df_r /ASYC_FIFO_tb/DUT/df2_r/ff1
add wave -noupdate -expand -group {FIFO Write} /ASYC_FIFO_tb/DUT/WR/w_inc
add wave -noupdate -expand -group {FIFO Write} /ASYC_FIFO_tb/DUT/WR/gray_rptr
add wave -noupdate -expand -group {FIFO Write} /ASYC_FIFO_tb/DUT/WR/gray_wptr
add wave -noupdate -expand -group {FIFO Write} /ASYC_FIFO_tb/DUT/WR/w_addr
add wave -noupdate -expand -group {FIFO Write} /ASYC_FIFO_tb/DUT/WR/FULL
add wave -noupdate -expand -group {FIFO Write} /ASYC_FIFO_tb/DUT/WR/bin_wptr
add wave -noupdate -expand -group {FIFO Read} /ASYC_FIFO_tb/DUT/RD/r_inc
add wave -noupdate -expand -group {FIFO Read} /ASYC_FIFO_tb/DUT/RD/gray_wptr
add wave -noupdate -expand -group {FIFO Read} /ASYC_FIFO_tb/DUT/RD/gray_rptr
add wave -noupdate -expand -group {FIFO Read} /ASYC_FIFO_tb/DUT/RD/r_addr
add wave -noupdate -expand -group {FIFO Read} /ASYC_FIFO_tb/DUT/RD/EMPTY
add wave -noupdate -expand -group {FIFO Read} /ASYC_FIFO_tb/DUT/RD/bin_rptr
add wave -noupdate -expand -group {FIFO Mem} -expand /ASYC_FIFO_tb/DUT/mem/ram
add wave -noupdate -expand -group {FIFO Mem} /ASYC_FIFO_tb/DUT/mem/w_clken
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {92866 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {497700 ps}
