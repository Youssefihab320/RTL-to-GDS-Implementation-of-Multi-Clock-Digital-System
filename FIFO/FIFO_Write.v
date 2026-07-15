module FIFO_Write #(
    parameter ADDR_WIDTH = 3
) (
    // Inputs
    input wire w_inc,                               // Write increment signal (triggers a write operation)
    input wire w_clk,                               // Write clock
    input wire w_rst,                               // Asynchronous reset for the write logic
    input wire [ADDR_WIDTH : 0] gray_rptr,          // Synchronized Gray-code read pointer from the read clock domain

    // Outputs
    output wire [ADDR_WIDTH : 0] gray_wptr,         // Gray-code write pointer, sent to the read domain for synchronization
    output wire [ADDR_WIDTH - 1 : 0] w_addr,        // Binary write address for the FIFO memory
    output wire FULL                                // Flag indicating the FIFO is full.
);

// Internal register to hold the binary value of the write pointer
// It has ADDR_WIDTH bits to detect when the pointer wraps around
reg [ADDR_WIDTH : 0] bin_wptr;

// Binary to Gray conversion
assign gray_wptr = bin_wptr ^ (bin_wptr >> 1);

// The actual write address is the lower bits of the binary pointer
assign w_addr = bin_wptr [ADDR_WIDTH - 1 : 0];

// Full flag
assign FULL  = ((~(gray_wptr[(ADDR_WIDTH) : (ADDR_WIDTH - 1)]) == gray_rptr[(ADDR_WIDTH) : (ADDR_WIDTH - 1)]) && (gray_wptr[(ADDR_WIDTH - 2) : 0] == gray_rptr[(ADDR_WIDTH - 2) : 0]));
    
always @(posedge w_clk or negedge w_rst) 
    begin
        if(!w_rst)
            begin
                bin_wptr <= 'b0;
            end
        else if (w_inc && !FULL)
            begin
                // Increment the address
                bin_wptr <= bin_wptr + 1;
            end
    end

endmodule
