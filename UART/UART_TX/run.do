vlib work
vlog *.*v
vsim -voptargs=+acc work.uart_tx_top_tb
do wave.do
run -all