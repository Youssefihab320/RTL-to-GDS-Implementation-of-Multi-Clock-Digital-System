module df_sync #(
    parameter ADDR_WIDTH = 3
) (
    // Inputs 
    input wire clk,                                 // Destination clock
    input wire rst,                                 // Asynchronous active-low reset
    input wire [ADDR_WIDTH : 0] data_in,            // Input data from the source clock domain

    // Outputs 
    output reg [ADDR_WIDTH : 0] data_out       // Synchronized output data
);

reg [ADDR_WIDTH : 0] ff1;

// Two stages Flop sync
always @(posedge clk or negedge rst) 
    begin
        if (!rst)
            begin
                ff1 <= 0;
                data_out <= 0;
            end
        else 
            begin
                ff1 <= data_in;
                // Assign the synchronized output
                data_out <= ff1;
            end
    end

endmodule