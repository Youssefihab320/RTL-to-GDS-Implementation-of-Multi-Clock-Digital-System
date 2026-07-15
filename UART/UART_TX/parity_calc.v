module parity_calc #(
    parameter DATA_WIDTH = 8
)(
    // Inputs
    input wire [DATA_WIDTH - 1 : 0] p_data,            // Parallel data input
    input wire data_valid,              // Parity enable signal
    input wire par_typ,                 // Parity type: 0 for even, 1 for odd
    input wire busy,
    input wire reset,
    input wire clk,

    // Output
    output reg par_bit                  // Calculated parity bit
);

always @(posedge clk or negedge reset) 
    begin
        if (!reset)
            begin
                par_bit <= 1'b0;
            end
        else if (data_valid && !busy) 
            begin
                // Parity is enabled
                if (par_typ) 
                    begin 
                        // Odd parity: result is 1 if the number of 1s is even
                        par_bit <= ~(^p_data);
                    end 
                else 
                    begin
                        // Even parity: result is 1 if the number of 1s is odd
                        par_bit <= ^p_data;
                    end
            end
    end

endmodule