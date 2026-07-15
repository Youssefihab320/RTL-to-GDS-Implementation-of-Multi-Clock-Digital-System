module PULSE_GEN (
    // Inputs
    input wire CLK,
    input wire RST,
    input wire LVL_SIG,

    // Outputs
    output wire PULSE_SIG
);

// Internal Signals
reg ff1, ff2;

// Double flop sync
always @(posedge CLK or negedge RST) 
    begin
        if (!RST)
            begin
                ff1 <= 1'b0;
                ff2 <= 1'b0;
            end
        else 
            begin
                ff1 <= LVL_SIG;
                ff2 <= ff1;
            end
    end

// Generate the pulse
assign PULSE_SIG = ff1 && !ff2;
endmodule