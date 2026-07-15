module FIFO_Read #(
    parameter ADDR_WIDTH = 3
) (
    // Inputs 
    input wire r_clk,                           // Read clock
    input wire r_rst,                           // Asynchronous reset for the read logic
    input wire r_inc,                           // Read increment signal (triggers a read operation)
    input wire [ADDR_WIDTH : 0] gray_wptr,      // Synchronized Gray-code write pointer from the write clock domain

    // Outputs
    output wire [ADDR_WIDTH : 0] gray_rptr,     // Gray-code read pointer, sent to the write domain for synchronization
    output wire [ADDR_WIDTH - 1 : 0] r_addr,    // Binary read address for the FIFO memory
    output wire EMPTY                           // Flag indicating the FIFO is empty
);

// Internal register to hold the binary value of the read pointer
// It has ADDR_WIDTH + 1 bits to detect when the pointer wraps around
reg [ADDR_WIDTH : 0] bin_rptr;

// Binary to Gray conversion
assign gray_rptr = bin_rptr ^ (bin_rptr >> 1);

// The actual read address is the lower bits of the binary pointer
assign r_addr = bin_rptr [ADDR_WIDTH-1:0];

// Empty Flag: FIFO is empty when the read and write pointers are equal.
assign EMPTY = (gray_wptr == gray_rptr);

always @(posedge r_clk or negedge r_rst) 
    begin
        if (!r_rst) 
            begin
                bin_rptr <= 'b0;
            end   
        else if (r_inc && !EMPTY)
            begin
                // Increment the address
                bin_rptr <= bin_rptr + 1;
            end
    end

endmodule
