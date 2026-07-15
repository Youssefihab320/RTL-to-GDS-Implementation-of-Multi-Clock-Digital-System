onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {TB Signals} /RST_SYNC_tb/NUM_STAGES_tb
add wave -noupdate -expand -group {TB Signals} /RST_SYNC_tb/CLK_PERIOD
add wave -noupdate -expand -group {TB Signals} -color Brown /RST_SYNC_tb/CLK_tb
add wave -noupdate -expand -group {TB Signals} /RST_SYNC_tb/RST_tb
add wave -noupdate -expand -group {TB Signals} -color Magenta /RST_SYNC_tb/SYNC_RST_tb
add wave -noupdate -expand -group {DUT Signal} /RST_SYNC_tb/DUT/reset_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {65000 ps} 0}
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
WaveRestoreZoom {0 ps} {162750 ps}
