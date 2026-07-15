module serializer #(
    parameter DATA_WIDTH = 8
)(
    // Inputs
    input wire [DATA_WIDTH - 1 : 0] p_data,     // Parallel data to be serialized
    input wire ser_en,           // Serialization enable
    input wire clk,              // System clock
    input wire reset,            // Asynchronous reset (active low)
    input wire busy,
    input wire data_valid,

    // Outputs
    output wire ser_done,        // Signal indicating serialization is complete
    output wire ser_data         // Serial data output
);

    reg [7:0] data_reg;
    reg [2:0] bit_count;

// Logic for serial data output and done signal
assign ser_data = data_reg [bit_count];
assign ser_done = (bit_count == 3'd7);

// Register to hold the parallel data when serialization starts
always @(posedge clk or negedge reset) 
    begin
        if (!reset)
            begin
                data_reg <= 8'b0;
            end
        else if (data_valid && !busy)
            begin
                data_reg <= p_data;         // Load new data only at the beginning of a new serialization
            end
    end

// Counter to track the number of bits transmitted
always @(posedge clk or negedge reset) 
    begin
        if (!reset)
            begin
                bit_count <= 3'd0;
            end
        else if (ser_en)
            begin
                if (bit_count == 3'd7)
                    begin
                        bit_count <= 3'd0;      // Reset counter after 8 counts
                    end
                else 
                    begin
                        bit_count <= bit_count + 1;
                    end
            end
        else 
            begin
                bit_count <= 3'd0;          // Reset counter when not enabled
            end
    end

endmodule