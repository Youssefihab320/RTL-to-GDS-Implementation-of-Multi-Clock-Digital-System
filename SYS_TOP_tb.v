`timescale 1ns/1ps

module SYS_TOP_tb();

// DUT Parameters
parameter DATA_WIDTH_tb = 8;
parameter RF_ADDR_tb = 4;

// Testbench Registers for controlling parity
reg PAR_EN_tb;
reg PAR_TYP_tb;
reg calculated_parity_bit;

// DUT Inputs
reg RST_N_tb;
reg UART_CLK_tb;
reg REF_CLK_tb;
reg UART_RX_IN_tb;

// DUT Outputs
wire UART_TX_O_tb;
wire parity_error_tb;
wire framing_error_tb;

// Self-checking variables
reg [DATA_WIDTH_tb-1:0] received_data_tb;

// Generate the Clocks
// 1) REF Clock
parameter REF_CLK_PERIOD = 20; // 50 MHz => 20 ns
always #(REF_CLK_PERIOD / 2) REF_CLK_tb = ~ REF_CLK_tb;

// 2) UART CLK
parameter UART_CLK_PERIOD = 271.27; // 3.6864 MHz => 271.267 ns
always #(UART_CLK_PERIOD / 2) UART_CLK_tb = ~ UART_CLK_tb;

// TX clk period for receiving data
parameter TX_CLK_PERIOD = 8680;

// Instantiate the DUT
SYS_TOP #(
            .DATA_WIDTH(DATA_WIDTH_tb),
            .RF_ADDR(RF_ADDR_tb)
) U0_SYS_TOP (
            .RST_N(RST_N_tb),
            .UART_CLK(UART_CLK_tb),
            .REF_CLK(REF_CLK_tb),
            .UART_RX_IN(UART_RX_IN_tb),
            .UART_TX_O(UART_TX_O_tb),
            .parity_error(parity_error_tb),
            .framing_error(framing_error_tb)
);

always @(posedge parity_error_tb or posedge framing_error_tb)
    begin
            $display("Error Detected");
    end

initial 
    begin
        // System Functions
        $dumpfile("SYS_TOP.vcd") ;
        $dumpvars;
        
        // Starting Simulation
        $display("----------------------------");
        $display("Starting Simulation for SYS_TOP");
        // Initialize
        UART_CLK_tb = 0;
        REF_CLK_tb = 0;
        UART_RX_IN_tb = 1'b1; // IDLE State

        // Reset
        RST_N_tb = 1'b1;
        #(REF_CLK_PERIOD);
        RST_N_tb = 1'b0;
        #(REF_CLK_PERIOD);
        RST_N_tb = 1'b1;
        
        // Wait for reset to propagate
        #(REF_CLK_PERIOD * 10);
        
        // Let's test writing the value 0xF0 to address 5.
        $display("Sending command to write 0xF0 to address 5...");
        // Frame 0: Write Command (0xAA)
        send_uart_frame(8'hAA, 1'b1, 1'b0, 1'b0);
        // Frame 1: Address (0x05)
        send_uart_frame(8'h05, 1'b1, 1'b0, 1'b0);
        // Frame 2: Data (0xF0)
        send_uart_frame(8'hF0, 1'b1, 1'b0, 1'b0);
        
        
        $display("Reading from memory address 5");
        // Frame 0: Read Command (0xBB)
        send_uart_frame(8'hBB, 1'b1, 1'b0, 1'b0);
        // Frame 1: Address (0x05)
        send_uart_frame(8'h05, 1'b1, 1'b0, 1'b0);

        // We expect the DUT to transmit the data we just wrote (0xF0).
        receive_uart_frame(8'hF0);

        $display("Changing the Prescale value to 16");
        $display("Sending command to config reg");
        // Frame 0: Write Command (0xAA)
        send_uart_frame(8'hAA, 1'b1, 1'b0, 1'b0);
        // Frame 1: Address (0x02)
        send_uart_frame(8'h02, 1'b1, 1'b0, 1'b0);
        // Frame 2: Data ('d16)
        send_uart_frame(8'b01000001, 1'b1, 1'b0, 1'b0);

        $display("Sending command to perform ALU operation subtraction");
        // Frame 0: ALU Command (0xCC)
        send_uart_frame(8'hCC, 1'b1, 1'b0, 1'b0);
        // Frame 1: Operand A (0x04)
        send_uart_frame(8'h04, 1'b1, 1'b0, 1'b0);
        // Frame 2: Operand B (0x02)
        send_uart_frame(8'h02, 1'b1, 1'b0, 1'b0);
        // Frame 3:ALU FUN (Sub : 0x1)
        send_uart_frame(8'h01, 1'b1, 1'b0, 1'b0);
        
        // Check the Data transmitted 
        receive_uart_frame(8'h02);

        $display("Injecting Parity Error");
        // Use Odd parity instead of configured even parity
        send_uart_frame(8'hAA, 1'b1, 1'b1, 1'b0);

        $display("Injecting Stop Error");
        send_uart_frame(8'hAA, 1'b1, 1'b0, 1'b1);

        $display("Sending command to perform ALU operation Compare");
        // Frame 0: ALU Command (0xCC)
        send_uart_frame(8'hCC, 1'b1, 1'b0, 1'b0);
        // Frame 1: Operand A (0x3A)
        send_uart_frame(8'h3A, 1'b1, 1'b0, 1'b0);
        // Frame 2: Operand B (0x0C)
        send_uart_frame(8'h0C, 1'b1, 1'b0, 1'b0);
        // Frame 3:ALU FUN (Compare : 0x1)
        send_uart_frame(8'b1011, 1'b1, 1'b0, 1'b0);
        
        // Check the Data transmitted 
        receive_uart_frame(8'd2);

        $display("Sending command to perform ALU operation Addition (No Operand)");
        // Frame 0: ALU Command (0xDD)
        send_uart_frame(8'hDD, 1'b1, 1'b0, 1'b0);
        // Frame 1:ALU FUN (ADD : 0x0)
        send_uart_frame(8'b0, 1'b1, 1'b0, 1'b0);

        // Check the Data transmitted 
        receive_uart_frame(8'd70);

        // Stop simulation after the test
        #(30*TX_CLK_PERIOD);
        $stop;
    end

// Task to receive a UART frame and check its data
task receive_uart_frame;
    input [7:0] expected_data;
    integer i;

    begin
        $display("Waiting to receive a UART frame...");

        // 1. Wait for the start bit (high to low transition)
        @(negedge UART_TX_O_tb);
        $display("Start bit detected!");

        // 2. Wait half a bit period to sample in the middle of the bit
        #(TX_CLK_PERIOD / 2);

        // 3. Sample the 8 data bits (LSB first)
        for (i = 0; i < 8; i = i + 1)
        begin
            #(TX_CLK_PERIOD); // Wait for the next bit period
            received_data_tb[i] = UART_TX_O_tb;
        end
        
        // 4. Wait for the stop bit period to end
        #(TX_CLK_PERIOD); 

        // 5. Perform the check
        $display("Frame received. Data: 0x%h", received_data_tb);
        if (received_data_tb == expected_data) 
            begin
                $display("Test Case Passed: Received data (0x%h) matches expected data (0x%h).", received_data_tb, expected_data);
            end 
        else 
            begin
                $display("Test Case Failed: Received data (0x%h) does NOT match expected data (0x%h).", received_data_tb, expected_data);
        end

        $display("----------------------------");

    end
endtask

// Tasks
task send_bit;
    input bit_value;
    begin
       UART_RX_IN_tb = bit_value;
       #(UART_CLK_PERIOD * 32); // TX CLK Period (Master)
    end
endtask

function automatic calculate_parity;
    input [7:0] in_data;
    reg par_bit;
    begin
        if (PAR_EN_tb)
            begin
                if (PAR_TYP_tb) 
                    begin 
                        // Odd parity
                        par_bit = ~(^in_data);
                    end 
                else 
                    begin
                        // Even parity
                        par_bit = ^(in_data);
                    end
            end
        else
            begin
                par_bit = 1'b0; // Default value if parity is not enabled
            end
        calculate_parity = par_bit;
    end
endfunction

task send_uart_frame;
    input [7:0] tx_data;
    input tx_par_en;
    input tx_par_typ;
    input corner_case_stp;
    integer i;
    begin
        // Set variables for the calculate_parity function to use
        PAR_EN_tb = tx_par_en;
        PAR_TYP_tb = tx_par_typ;

        $display("Start Transmitting UART Frame with data: 0x%h", tx_data);
        // Send Start bit
        send_bit (1'b0);
        // Send 8 bit data (LSB first)
        for (i = 0; i < 8; i = i + 1)
            begin
                send_bit (tx_data[i]);
            end
        
        // Send Parity bit if enabled for this specific frame
        if (tx_par_en)
            begin
                calculated_parity_bit = calculate_parity (tx_data);
                send_bit (calculated_parity_bit);        
            end
        
        // Send Stop bit 
        if (corner_case_stp)
            begin
                send_bit (1'b0);                                    // Injection of wrong stop bit
                $display("Error in stop bit returning to IDLE State");
            end
        else
            begin
                send_bit (1'b1);
            end
        $display("Finished Sending UART Frame");
        $display("----------------------------");
    end
endtask

endmodule