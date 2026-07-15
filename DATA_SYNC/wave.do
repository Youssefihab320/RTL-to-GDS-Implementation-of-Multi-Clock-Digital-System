onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {TB Signals} /DATA_SYNC_tb/NUM_STAGES_tb
add wave -noupdate -expand -group {TB Signals} /DATA_SYNC_tb/BUS_WIDTH_tb
add wave -noupdate -expand -group {TB Signals} /DATA_SYNC_tb/CLK_PERIOD
add wave -noupdate -expand -group {TB Signals} /DATA_SYNC_tb/RST_tb
add wave -noupdate -expand -group {TB Signals} -color {Violet Red} /DATA_SYNC_tb/CLK_tb
add wave -noupdate -expand -group {TB Signals} /DATA_SYNC_tb/Unsync_bus_tb
add wave -noupdate -expand -group {TB Signals} -color Goldenrod /DATA_SYNC_tb/bus_enable_tb
add wave -noupdate -expand -group {TB Signals} /DATA_SYNC_tb/sync_bus_tb
add wave -noupdate -expand -group {TB Signals} -color Magenta /DATA_SYNC_tb/enable_pulse_tb
add wave -noupdate -expand -group {DUT Signals} /DATA_SYNC_tb/DUT/enable_sync_reg
add wave -noupdate -expand -group {DUT Signals} /DATA_SYNC_tb/DUT/bus_enable_reg
add wave -noupdate -expand -group {DUT Signals} /DATA_SYNC_tb/DUT/enable_pulse_temp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {88525 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 157
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
WaveRestoreZoom {0 ps} {173250 ps}
