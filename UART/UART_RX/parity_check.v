module parity_check #(
    parameter DATA_WIDTH = 8
)(
    // Inputs
    input wire clk,                             // UART RX clock
    input wire reset,                           // Asynchronous active low reset
    input wire [DATA_WIDTH - 1 : 0] P_DATA,     // Output Parallel data of the deserializer
    input wire par_en,                          // Enable for the parity
    input wire par_typ,                         // Parity type: 0 for even, 1 for odd
    input wire par_chk_en,                      // Parity checker enable
    input wire sampled_bit,                     // Sampled bit to be deserialized
    input wire [3:0] bit_cnt,

    // Outputs 
    output reg par_err         // Parity error signal
);
    reg par_bit;                // Parity bit calculation

always @(posedge clk or negedge reset) 
    begin
        if (!reset)
            begin
                par_bit <= 1'b0;
                par_err <= 1'b0;
            end
        else if (par_en)
            begin
                // Parity is enabled
                if (par_typ) 
                    begin 
                        // Odd parity: result is 1 if the number of 1s is even
                        par_bit <= ~(^P_DATA);
                    end 
                else 
                    begin
                        // Even parity: result is 1 if the number of 1s is odd
                        par_bit <= ^P_DATA;
                    end
                if (par_chk_en)
                    begin
                        par_err <= !(par_bit == sampled_bit);
                    end
                else if (bit_cnt == 0)
                    begin
                        par_err <= 1'b0;
                    end
            end
    end

endmodule