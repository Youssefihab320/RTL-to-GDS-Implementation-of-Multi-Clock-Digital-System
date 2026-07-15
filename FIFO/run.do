vlib work
vlog *.*v
vsim -voptargs=+acc work.ASYC_FIFO_tb
do wave.do
run -all