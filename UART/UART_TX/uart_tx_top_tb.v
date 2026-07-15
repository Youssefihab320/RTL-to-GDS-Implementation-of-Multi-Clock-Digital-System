`timescale 1ns/1ps

module uart_tx_top_tb ();

    // DUT Inputs
    reg [7:0] P_DATA_tb;
    reg RST_tb;
    reg CLK_tb;
    reg Data_Valid_tb;
    reg PAR_TYP_tb;
    reg PAR_EN_tb;

    // Outputs
    wire TX_OUT_tb;
    wire busy_tb;

    // For checking output
    reg [9:0] data_reg_no_par;
    reg [10:0] data_reg_par;
    reg [9:0] expected_output_no_par;
    reg [10:0] expected_output_par;
    reg [2:0] operation_count;                              // To visualize current test case number
    integer i;
    // A local variable to hold the calculated parity bit
    reg parity_bit_calc;

// Instantiating the Design
uart_tx_top DUT (
                .P_DATA(P_DATA_tb),
                .RST(RST_tb),
                .CLK(CLK_tb),
                .Data_Valid(Data_Valid_tb),
                .PAR_TYP(PAR_TYP_tb),
                .PAR_EN(PAR_EN_tb),
                .TX_OUT(TX_OUT_tb),
                .busy(busy_tb)
);

// Generate clock with 200 MHZ => 5 ns period
parameter Clock_Period = 5;                     // CLOCK PERIOD Parameter
always #(Clock_Period/2) CLK_tb = ~ CLK_tb;

initial 
    begin
        // System Functions
        $dumpfile("UART_TX.vcd") ;       
        $dumpvars;
        
        // Starting Simulation
        $display("----------------------------");               // Separator to indicate Simulation start
        $display("Starting Simulation for UART_TX");

        // Initialize signals
        initialize();

        // Reset 
        reset();

        // Test Case 1
        $display("Test Case 1: Enabled Even Parity");
        apply_stimulus(
                        8'b11010110,        // Parallel Data in
                        1'b1,               // Enabled Parity
                        1'b0                // Even Parity
        );

        // Test Case 2
        $display("Test Case 2: Enabled Odd Parity");
        apply_stimulus(
                        8'b01110011,        // Parallel Data in
                        1'b1,               // Enabled Parity
                        1'b1                // Odd Parity
        );

        // Test Case 3
        $display("Test Case 3: Disabled Parity");
        apply_stimulus(
                        8'b11100001,        // Parallel Data in
                        1'b0,               // Disabled Parity
                        1'bx
        );

        // Test Case 4
        $display("Test Case 4: Data_Vaid High Mid Processing");
        apply_corner_case(
                        8'b00111100,        // Parallel Data in
                        8'b10101011,
                        1'b1,               // Enabled Parity
                        1'b0                // Even Parity
        );

        // Test Case 5
        $display("Test Case 5: All ones");
        apply_stimulus(
                        8'b11111111,        // Parallel Data in
                        1'b1,               // Enabled Parity
                        1'b1                // Odd Parity
        );

        // Test Case 6
        $display("Test Case 6: All Zeroes");
        apply_stimulus(
                        8'b00000000,        // Parallel Data in
                        1'b1,               // Enabled Parity
                        1'b0                // Odd Parity
        );

        // Test Case 7
        $display("Test Case 7: Alternating Data");
        apply_stimulus(
                        8'b10101010,        // Parallel Data in
                        1'b1,               // Enabled Parity
                        1'b0                // Even Parity
        );        

        // Ending Simulation
        $display("Simulation Done");
        $stop;
    end

// Tasks
task initialize; 
    begin
        // Ports
        CLK_tb = 0;
        P_DATA_tb = 0;
        Data_Valid_tb = 0;
        PAR_TYP_tb = 0;
        PAR_EN_tb = 0;
        // Internal Signals for testing
        data_reg_no_par = 0;
        data_reg_par = 0;
        i = 0;
        expected_output_no_par = 0;
        expected_output_par = 0;
        operation_count = 0;
    end
endtask

task reset;
    begin
        RST_tb = 1;
        #Clock_Period;
        RST_tb = 0;
        #Clock_Period;
        RST_tb = 1;
        #Clock_Period;
        // Checking if Reset is Succeeded
        if(TX_OUT_tb == 1'b1 && busy_tb == 1'b0)
            $display("Reset Done => TX_OUT = %0b , busy = %0b", TX_OUT_tb, busy_tb);
        else
            $display("Reset Failed => TX_OUT = %0b , busy = %0b", TX_OUT_tb, busy_tb);
    end
endtask

task apply_stimulus;
    // Internal arguments
    input [7:0] data;               
    input par_en;
    input par_typ;
    begin
        // Loading passed arguments into ports
        P_DATA_tb = data;
        PAR_EN_tb = par_en;
        PAR_TYP_tb = par_typ;
        // Stimulus
        Data_Valid_tb = 1'b1;
        #Clock_Period;
        Data_Valid_tb = 1'b0;
        check_operation();                                  // Checking Operation
        wait (busy_tb == 0);                                // Waiting untill busy equals zero to start a new operation
        $display("----------------------------");           // Separation between test cases
    end
endtask

task check_operation;
    begin
        // Loading transmitted data into a reg for comparison and visualization
        operation_count = operation_count + 1;
        if(busy_tb)
            begin
                // Data is saved in the reg starting from Start bit at the LSB (Reversed)
                if(PAR_EN_tb)
                    begin
                        for (i = 0; i < 11; i= i + 1)
                            begin
                                @(negedge CLK_tb);
                                data_reg_par[i] = TX_OUT_tb;                
                            end
                        expected_out();
                        $display("Generated Output = %0b & Expected Output = %0b",data_reg_par, expected_output_par);
                        if (expected_output_par == data_reg_par)
                            $display("Test Case %0d Passed", operation_count);
                        else 
                            $display("Test Case %0d Failed", operation_count);
                    end
                else
                    begin
                        for (i = 0; i < 10; i= i + 1)
                            begin
                                @(negedge CLK_tb);
                                data_reg_no_par[i] = TX_OUT_tb;
                            end
                        expected_out();
                        $display("Generated Output = %0b & Expected Output = %0b",data_reg_no_par, expected_output_no_par); 
                        if (expected_output_no_par == data_reg_no_par)
                            $display("Test Case %0d Passed", operation_count);
                        else 
                            $display("Test Case %0d Failed",operation_count);
                    end                    
            end
    end
endtask

task expected_out;
    begin
        if (PAR_EN_tb)
            begin
                // Calculate parity bit based on the parity type
                if (PAR_TYP_tb)
                    begin
                        // Odd parity: result is 1 if the number of 1s is even
                        parity_bit_calc = ~(^P_DATA_tb);
                    end
                else
                    begin
                        // Even parity: result is 1 if the number of 1s is odd
                        parity_bit_calc = ^P_DATA_tb;
                    end
                
                // Assign the full expected output frame with the calculated parity bit
                // Starting from Stop bit (Reversed)
                expected_output_par = {1'b1, parity_bit_calc, P_DATA_tb, 1'b0};
            end
        else
            begin
                expected_output_no_par = {1'b1, P_DATA_tb, 1'b0};
            end 
    end
endtask

task apply_corner_case;
    input [7:0] data;
    input [7:0] data_mid;               
    input par_en;
    input par_typ;
    begin
        operation_count = operation_count + 1;
        // Loading passed arguments into ports
        P_DATA_tb = data;
        PAR_EN_tb = par_en;
        PAR_TYP_tb = par_typ;
        // Stimulus
        Data_Valid_tb = 1'b1;
        #Clock_Period;
        Data_Valid_tb = 1'b0;
        #(6*Clock_Period);

        // Stimulus
        $display("Applying second stimulus while busy is high. This should be ignored.");
        P_DATA_tb = data_mid;
        Data_Valid_tb = 1'b1;
        #Clock_Period;
        Data_Valid_tb = 1'b0;

        if(!busy_tb && TX_OUT_tb)
            $display("Test Case %0d Failed: UART should have been busy and ignored the new data", operation_count);
        else
            $display("Test Case %0d Passed: Second stimulus was correctly ignored", operation_count);
        
        #(4*Clock_Period);                                  // To make sure data_mid isn't processed
        $display("----------------------------");           // Separation between test cases
    end
endtask

endmodule