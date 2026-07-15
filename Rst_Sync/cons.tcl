
# Constraints
# ----------------------------------------------------------------------------
#
# 1. Master Clock Definitions
#
# 2. Generated Clock Definitions
#
# 3. Clock Uncertainties
#
# 4. Clock Latencies 
#
# 5. Clock Relationships
#
# 6. set input/output delay on ports
#
# 7. Driving cells
#
# 8. Output load

####################################################################################
           #########################################################
                  #### Section 1 : Clock Definition ####
           #########################################################
#################################################################################### 
# 1. Master Clock Definitions 
# 2. Generated Clock Definitions
# 3. Clock Latencies
# 4. Clock Uncertainties
# 4. Clock Transitions
####################################################################################

set CLK_NAME CLK
set CLK_PER 8680
set CLK_SETUP_SKEW 0.25
set CLK_HOLD_SKEW 0.05
set CLK_LAT 0
set CLK_RISE 0.1
set CLK_FALL 0.1

create_clock -name $CLK_NAME -period $CLK_PER -waveform "0 [expr $CLK_PER/2]" [get_ports CLK]
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks $CLK_NAME]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks $CLK_NAME]
set_clock_transition -rise $CLK_RISE  [get_clocks $CLK_NAME]
set_clock_transition -fall $CLK_FALL  [get_clocks $CLK_NAME]
set_clock_latency $CLK_LAT [get_clocks $CLK_NAME]

set_dont_touch_network CLK

create_clock -name "scan_clk" -period 10000 -waveform "0 5000" [get_ports scan_clk]
set_clock_uncertainty -setup 0.025 [get_clocks scan_clk]
set_clock_uncertainty -hold 0.01 [get_clocks scan_clk]
#set_clock_transition 0.05 [get_clocks scan_clk]
set_dont_touch_network "scan_clk"


####################################################################################
           #########################################################
                  #### Section 2 : Clocks Relationships ####
           #########################################################
####################################################################################
set_clock_groups -asynchronous -group "$CLK_NAME" -group "scan_clk"

####################################################################################
           #########################################################
             #### Section 3 : set input/output delay on ports ####
           #########################################################
####################################################################################

set in_delay  [expr 0.3*$CLK_PER]
set out_delay [expr 0.3*$CLK_PER]
set in_delay_scan [expr 0.3*10000]
set out_delay_scan [expr 0.3*10000]

#Constrain Input Paths
set_input_delay $in_delay -clock $CLK_NAME [get_port P_DATA]
set_input_delay $in_delay -clock $CLK_NAME [get_port Data_Valid]
set_input_delay $in_delay -clock $CLK_NAME [get_port PAR_TYP]
set_input_delay $in_delay -clock $CLK_NAME [get_port PAR_EN]

#Constrain Scan Input Paths
set_input_delay $in_delay_scan -clock scan_clk [get_ports {SI SE}]

#Constrain Output Paths
set_output_delay $out_delay -clock $CLK_NAME [get_port TX_OUT]
set_output_delay $out_delay -clock $CLK_NAME [get_port busy]

#Constrain Scan Output Paths
set_output_delay $out_delay_scan -clock scan_clk [get_ports SO]

####################################################################################
           #########################################################
                  #### Section 4 : Driving cells ####
           #########################################################
####################################################################################
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port P_DATA]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port Data_Valid]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port PAR_TYP]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port PAR_EN]

#scan ports
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_ports {SE SI}]

####################################################################################
           #########################################################
                  #### Section 5 : Output load ####
           #########################################################
####################################################################################
set_load 0.5  [get_port TX_OUT]
set_load 0.5  [get_port busy]

#scan ports
set_load 0.1 [get_ports SO]

####################################################################################
           #########################################################
                 #### Section 6 : Operating Condition ####
           #########################################################
####################################################################################

# Define the Worst Library for Max(#setup) analysis
# Define the Best Library for Min(hold) analysis
set_operating_conditions -min_library "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -min "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -max_library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" -max "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"

####################################################################################
           #########################################################
                  #### Section 7 : wireload Model ####
           #########################################################
####################################################################################

#set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c

####################################################################################
           #########################################################
                  #### Section 8 : Case Analysis ####
           #########################################################
####################################################################################
set_case_analysis 1 [get_ports test_mode]

####################################################################################
           #########################################################
                  #### Section 9 : multicycle path ####
           #########################################################
####################################################################################


