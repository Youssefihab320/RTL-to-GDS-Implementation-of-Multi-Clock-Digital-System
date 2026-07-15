`timescale 1ns/1ps

module RST_SYNC_tb ();

// Parameter for number of stages to test
parameter NUM_STAGES_tb = 2;

// Dut Signals
reg CLK_tb;
reg RST_tb;

wire SYNC_RST_tb;

// Generating Clock => 10ns period, 100MHz clock
parameter CLK_PERIOD = 10;
always #(CLK_PERIOD / 2) CLK_tb = ~ CLK_tb;

// Instantiate the DUT
RST_SYNC #(
            .NUM_STAGES(NUM_STAGES_tb)
        ) DUT (
            .CLK(CLK_tb),
            .RST(RST_tb),
            .SYNC_RST(SYNC_RST_tb)
        );

initial 
    begin
        $display("-------------------------------------------------------");
        $display("Starting simulation of the RST Synchronizer Testbench");
        $display("Test case 1: Asynchronous Reset Assertion and Synchronous De-assertion on negedge clk");

        // Intialize Clock
        CLK_tb = 1'b0;

        RST_tb= 1'b0;     // Assert the asynchronous reset
        #(CLK_PERIOD);
        
        // Wait for a few clock cycles to observe the asserted reset
        #(2 * CLK_PERIOD);

        // De-assert the reset asynchronously
        RST_tb = 1'b1;
    
        // Wait for enough time to allow the synchronized reset to de-assert
        #(6 * CLK_PERIOD);
        
        // Final check and display results
        if (SYNC_RST_tb === 1'b1) 
            begin
                $display("Test Passed: The synchronized reset de-asserted successfully.");
            end 
        else 
            begin
                $display("Test Failed: The synchronized reset did not de-assert.");
            end
        
        $display("----------------------------------");
        
        $display("Test case 2: Asynchronous Reset Assertion and Synchronous De-assertion on posedge clk");
        // De_assert the reset on posedge of clk
        RST_tb = 1'b0;
        #(CLK_PERIOD / 2);
        RST_tb = 1'b1;
        #(6*CLK_PERIOD);

        // Final check and display results
        if (SYNC_RST_tb === 1'b1) 
            begin
                $display("Test Passed: The synchronized reset de-asserted successfully.");
            end 
        else 
            begin
                $display("Test Failed: The synchronized reset did not de-assert.");
            end

        $display("Simulation finished");
        $stop;
    end
endmodule