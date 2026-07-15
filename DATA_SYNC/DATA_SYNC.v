module DATA_SYNC #(
    // Parameter for the number of flip-flop stages in the synchronizer chain
    parameter NUM_STAGES = 2,
    // Parameter for the width of the unsynchronized and synchronized data buses.
    parameter BUS_WIDTH = 8
) (
    // Inputs
    input wire [BUS_WIDTH - 1 : 0] Unsync_bus,      // Unsynchronized data bus from the source clock domain
    input wire bus_enable,                          // Unsynchronized enable signal from the source clock domain
    input wire CLK,             // Destination clock domain
    input wire RST,             // Asynchronous Reset (active low)
    
    // Outputs
    output reg [BUS_WIDTH - 1 : 0] sync_bus,        // Synchronized data bus in the destination clock domain
    output reg enable_pulse                         // Synchronized enable pulse in the destination clock domain
);

// Internal registers for the multi-stage flip-flop synchronizer chain.
reg [NUM_STAGES-1 : 0] enable_sync_reg;                       // Multi-Flop Chain
reg bus_enable_reg;                                           // To hold the value of the last FF in the chain

wire enable_pulse_temp;

// Multi-stage flip-flop synchronizer for the bus_enable signal.
// This is the core of the synchronizer to dec the prob of metastability.
always @(posedge CLK or negedge RST) 
    begin
        if (!RST)
            begin
                enable_sync_reg <= {NUM_STAGES{1'b0}};
            end
        else
            begin
                enable_sync_reg <= {enable_sync_reg[NUM_STAGES - 2 : 0], bus_enable};
            end
    end
    
// Logic for the pulse generator and the synchronized data bus.
always @(posedge CLK or negedge RST) 
    begin
        if (!RST)
            begin
                sync_bus <= {BUS_WIDTH{1'b0}};
                enable_pulse <= 1'b0;
                bus_enable_reg <= 1'b0;
            end
        else 
            begin
                // Synchronized enable pulse generation logic.
                // It's a single clock cycle pulse triggered by the rising edge of the synchronized enable signal
                bus_enable_reg <= enable_sync_reg[NUM_STAGES-1];
                
                enable_pulse <= enable_pulse_temp;

                // MUX-select synchronization scheme for the data bus
                // The synchronized bus is updated only when the enable pulse is high
                if (enable_pulse_temp)
                    begin
                        sync_bus <= Unsync_bus;
                    end

            end
    end

// Comb logic of enable_pulse to be fed to the mux
assign enable_pulse_temp = enable_sync_reg[NUM_STAGES-1] & ~ bus_enable_reg;

endmodule
