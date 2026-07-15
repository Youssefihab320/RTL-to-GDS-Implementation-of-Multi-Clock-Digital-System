`timescale 1ns/1ps

module DATA_SYNC_tb();

// Parameters
parameter NUM_STAGES_tb = 2;
parameter BUS_WIDTH_tb = 8;
parameter CLK_PERIOD = 10 ;         // 10 ns for a 100 MHz clock

// Dut Signals
reg RST_tb;
reg CLK_tb;
reg [BUS_WIDTH_tb - 1 : 0] Unsync_bus_tb;
reg bus_enable_tb;

wire [BUS_WIDTH_tb - 1 : 0] sync_bus_tb;
wire enable_pulse_tb;

// Instantiate the DUT
DATA_SYNC #(
            .NUM_STAGES(NUM_STAGES_tb),
            .BUS_WIDTH(BUS_WIDTH_tb)
) DUT (
            .RST(RST_tb),
            .CLK(CLK_tb),
            .Unsync_bus(Unsync_bus_tb),
            .bus_enable(bus_enable_tb),
            .sync_bus(sync_bus_tb),
            .enable_pulse(enable_pulse_tb)
);

// Generating the Clock
always #(CLK_PERIOD / 2) CLK_tb = ~ CLK_tb;

initial
    begin
        // System Functions
        $dumpfile("DATA_SYNC.vcd") ;       
        $dumpvars;
        
        // Starting Simulation
        $display("----------------------------");               // Separator to indicate Simulation start
        $display("Starting Simulation for DATA_SYNC");

        // Initialize
        initialize();

        // Reset
        reset();

        // Applying Stimulus
        $display("Test Case 1: Enabling the bus with Data 0xAA");
        apply_stimulus('hAA, 1'b1);

        $display("Test Case 2: Disabling the bus with Data 0xFA");
        apply_stimulus('hFA, 1'b0);
        
        $display("Test Case 3: Re-enabling the bus with Data 0xC2");
        apply_stimulus('hC2,1'b1);

        $stop;
    end

// Tasks
task initialize;
    begin
        CLK_tb = 1'b0;
        Unsync_bus_tb = 0;
        bus_enable_tb = 0;
    end
endtask

task reset;
    begin
        RST_tb = 1'b1;
        #(CLK_PERIOD);
        RST_tb = 1'b0;
        #(CLK_PERIOD);
        RST_tb = 1'b1;
    end
endtask

task apply_stimulus;
    input [BUS_WIDTH_tb - 1 : 0] Unsync_data;
    input bus_en;
    begin
        @(negedge CLK_tb);
        Unsync_bus_tb = Unsync_data;
        bus_enable_tb = bus_en;

        if (bus_enable_tb)
            begin
                wait (enable_pulse_tb);
                if (enable_pulse_tb & (sync_bus_tb == Unsync_data))
                    $display("Test Case Passed");
                else         
                    $display("Test Case Failed");
            end
        else
            begin
                if (!enable_pulse_tb)
                    $display("Test Case Passed");
                else         
                    $display("Test Case Failed");
            end

        #(CLK_PERIOD * 3);

        $display("----------------------------");               // Separator between testcases    
        
    end
endtask
endmodule