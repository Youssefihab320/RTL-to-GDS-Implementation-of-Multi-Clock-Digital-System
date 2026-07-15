`timescale 1ns/1ps

module ASYC_FIFO_tb ();

// Parameters
parameter DATA_WIDTH_tb = 8;
parameter DEPTH_tb = 8;
parameter ADDR_WIDTH_tb = 3;
parameter W_CLK_PERIOD = 10;
parameter R_CLK_PERIOD = 25.0;

// DUT Inputs
reg W_CLK_tb;
reg W_RST_tb;
reg W_INC_tb;
reg R_CLK_tb;
reg R_RST_tb;
reg R_INC_tb;
reg [DATA_WIDTH_tb - 1 : 0] WR_DATA_tb;

// DUT Outputs
wire FULL_tb;
wire EMPTY_tb;
wire [DATA_WIDTH_tb - 1 : 0] RD_DATA_tb;

// Test variables
reg [DATA_WIDTH_tb-1:0] expected_data [0:DEPTH_tb-1];
integer wr_index;
integer rd_index;

// Instantiating the DUT
ASYC_FIFO_Top #(
                .DATA_WIDTH(DATA_WIDTH_tb),
                .DEPTH(DEPTH_tb),
                .ADDR_WIDTH(ADDR_WIDTH_tb)
) DUT (
                .W_CLK(W_CLK_tb),
                .W_RST(W_RST_tb),
                .W_INC(W_INC_tb),
                .R_CLK(R_CLK_tb),
                .R_RST(R_RST_tb),
                .R_INC(R_INC_tb),
                .WR_DATA(WR_DATA_tb),
                .FULL(FULL_tb),
                .EMPTY(EMPTY_tb),
                .RD_DATA(RD_DATA_tb)
);

// Generating the write Clock (10 ns => 100 MHz)
always #(W_CLK_PERIOD / 2) W_CLK_tb = ~ W_CLK_tb;

// Generating the read clock (25 ns => 40 MHz)
always #(R_CLK_PERIOD / 2.0) R_CLK_tb = ~ R_CLK_tb;

// Initial block for setup and write operations
initial 
    begin
        // System Functions
        $dumpfile("ASYC_FIFO.vcd");       
        $dumpvars;
        
        // Starting Simulation
        $display("----------------------------");
        $display("Starting Simulation for ASYC_FIFO");
        
        // Initialize Signals
        w_initialize();

        // Apply active-low reset for the write side
        w_reset();

        // Write data
        write_data(10);
    end 
    
// Initial block for read operations and final simulation control
initial begin
    // Initialize Read side signals
    rd_initialize();

    // Apply active-low reset for the read side
    rd_reset();
    
    // Loop to read data
    read_data(10);

    // End of simulation after a short delay
    #(6 * R_CLK_PERIOD);
    $display("----------------------------");
    $display("Simulation Finished");
    $stop;
end

//Tasks
task w_initialize;
    begin
        // Write initialize
        W_CLK_tb = 0;
        W_INC_tb = 0;
        WR_DATA_tb = 0;
        wr_index = 0;
    end
endtask

task w_reset;
    begin
        // Write reset
        W_RST_tb = 1'b0;        
        #(W_CLK_PERIOD);
        W_RST_tb = 1'b1;
    end
endtask

task write_data;
    input [3:0] repeat_count_wr;
    begin
        #(2*W_CLK_PERIOD);        
        repeat (repeat_count_wr) begin
            @(negedge W_CLK_tb);
            // Increment data on each write for easier debugging. Note: WR_DATA_tb will be 1 on the first write
            WR_DATA_tb = WR_DATA_tb + 1;    
            W_INC_tb = 1'b1;
            @(posedge W_CLK_tb);

            if (!FULL_tb)
                begin
                    expected_data[wr_index] = WR_DATA_tb;
                    $display("Wrote 0x%0h to FIFO mem in address %0d", WR_DATA_tb, wr_index);
                    if (wr_index < 7)
                        wr_index = wr_index + 1;
                    else
                        wr_index = 0;
                end
        end
        
        @(negedge W_CLK_tb);
        W_INC_tb = 1'b0;                // Deassert write enable
    end
endtask

task rd_initialize;
    begin
        // Read Initialize
        R_CLK_tb = 0;
        R_INC_tb = 0;
        rd_index = 0;
    end
endtask

task rd_reset;
    begin
        // Read Reset
        R_RST_tb = 1'b0;
        #(R_CLK_PERIOD);
        R_RST_tb = 1'b1;
    end
endtask

task read_data;
    input [3:0] repeat_count_rd;
    begin
        // Wait for 2 clock cycles and then start the burst read
        // For testing
        #(2 * R_CLK_PERIOD);
        R_INC_tb = 1'b1;

        // Data is available on the NEXT clock edge after R_INC is asserted
        // We loop and check the data at each subsequent clock edge
        repeat (repeat_count_rd)
            begin
                @(posedge R_CLK_tb);            // Wait for the next clock edge for data to be valid
                
                // Now, check the data from the previously initiated read
                $display("Checking index %0d. Read: 0x%0h, Expected: 0x%0h", rd_index, RD_DATA_tb, expected_data[rd_index]);
                if (RD_DATA_tb == expected_data[rd_index])
                    $display("Test Case Passed");
                else
                    $display("Test Case Failed");
                
                if(rd_index < 7)
                    rd_index = rd_index + 1;
                else
                    rd_index = 0;
            end 
        
        // After the burst read is complete, deassert the read enable
        @(negedge R_CLK_tb);
        R_INC_tb = 1'b0;
    end
endtask

endmodule
