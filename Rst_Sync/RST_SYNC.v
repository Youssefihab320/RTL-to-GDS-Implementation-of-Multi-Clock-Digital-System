module RST_SYNC #(
    parameter NUM_STAGES = 2    // The number of flip-flop stages to use for synchronization    
)(
    // Inputs
    input wire CLK,             // Clock signal for the destination domain
    input wire RST,             // Asynchronous active-low reset signal

    // Outputs
    output wire SYNC_RST        // Synchronized active-low reset output (de-assertion only)
);

// Register to hold the synchronized reset values for each stage
// To model stages of flip flops
reg [NUM_STAGES - 1 : 0] reset_reg;

always @(posedge CLK or negedge RST) 
    begin
        if (!RST)
            begin
                // Asynchronous reset assertion
                reset_reg <= {NUM_STAGES{1'b0}};                
            end
        else
            begin
                // Synchronous reset de-assertion
                // Shift the input `1'b1` through the stages on each positive clock edge
                reset_reg <= {reset_reg[NUM_STAGES - 2 : 0], 1'b1};
            end
    end

// The final output is the output of the last flip-flop in the chain
assign SYNC_RST = reset_reg[NUM_STAGES - 1];

endmodule