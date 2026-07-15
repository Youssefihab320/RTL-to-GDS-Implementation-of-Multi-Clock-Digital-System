
###################################################################
########################### Variables #############################
###################################################################

set SSLIB "/home/IC/Assignments/Ass_Formal_1.0/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/IC/Assignments/Ass_Formal_1.0/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/IC/Assignments/Ass_Formal_1.0/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

###################################################################
############################ Guidance #############################
###################################################################

# Synopsys setup variable

set synopses_auto_setup true

# Formality Setup File

set_svf "/home/IC/Assignments/Ass_Formal_1.0/syn/default.svf"

###################################################################
###################### Reference Container ########################
###################################################################

# Read Reference Design Verilog Files

read_verilog -container Ref "/home/IC/Assignments/Ass_Formal_1.0/rtl/uart_tx_top.v"
read_sverilog -container Ref "/home/IC/Assignments/Ass_Formal_1.0/rtl/uart_fsm.sv"
read_verilog -container Ref "/home/IC/Assignments/Ass_Formal_1.0/rtl/serializer.v"
read_verilog -container Ref "/home/IC/Assignments/Ass_Formal_1.0/rtl/parity_calc.v"
read_verilog -container Ref "/home/IC/Assignments/Ass_Formal_1.0/rtl/mux.v"

# Read Reference technology libraries

read_db -container Ref [list $SSLIB $TTLIB $FFLIB]

# set the top Reference Design 

set_reference_design uart_tx_top
set_top uart_tx_top

###################################################################
#################### Implementation Container #####################
###################################################################

# Read Implementation Design Files

read_verilog -netlist -container Imp "/home/IC/Assignments/Ass_Formal_1.0/syn/UART_TX.v"

# Read Implementation technology libraries

read_db -container Imp [list $SSLIB $TTLIB $FFLIB]

# set the top Implementation Design

set_implementation_design uart_tx_top
set_top uart_tx_top


###################### Matching Compare points ####################

match

######################### Run Verification ########################

set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

########################### Reporting ############################# 
report_passing_points > "passing_points.rpt"
report_failing_points > "failing_points.rpt"
report_aborted_points > "aborted_points.rpt"
report_unverified_points > "unverified_points.rpt"


#start_gui


