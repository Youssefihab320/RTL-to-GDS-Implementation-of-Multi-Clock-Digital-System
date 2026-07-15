module fifo_mem #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 8,
    parameter ADDR_WIDTH = 3
) (
    // Inputs
    input wire w_clk,                           // Write Clock
    input wire w_rst,                           // Active low asynchronus reset
    input wire FULL,                            // FIFO full flag
    input wire w_inc,                           // write address increment enable
    input wire [ADDR_WIDTH - 1 : 0] w_addr,     // Write address
    input wire [ADDR_WIDTH - 1 : 0] r_addr,     // Read address
    input wire [DATA_WIDTH - 1 : 0] w_data,     // Write data

    // Outputs
    output wire [DATA_WIDTH - 1 : 0] r_data          // Read data
);

reg [DATA_WIDTH - 1 : 0] ram [0 : DEPTH - 1];

wire w_clken;                       // Write enable
assign w_clken = (w_inc & !FULL);

integer i;

// Write operation
always @(posedge w_clk or negedge w_rst) 
    begin
        if (!w_rst)
            begin
            // Reset the memory content to all zeros
            for (i = 0; i < DEPTH; i = i + 1) 
                begin
                    ram[i] <= 0;
                end
            end
        else if (w_clken)           
            begin
                ram[w_addr] <= w_data;
            end
    end
    
// Read Operation
assign r_data = ram[r_addr];

endmodule