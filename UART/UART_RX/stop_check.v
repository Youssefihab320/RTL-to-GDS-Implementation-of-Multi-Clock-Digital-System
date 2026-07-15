module stop_check (
    // Inputs
    input wire clk,                 // UART RX clock
    input wire reset,               // Asynchronous active low reset
    input wire stp_chk_en,          // Enable for stop_check module
    input wire sampled_bit,         // Sampled bit to be deserialized
    input wire [3:0] bit_cnt,

    // Outpus
    output reg stp_err              // Stop bit error
);
    
always @(posedge clk or negedge reset) 
    begin
        if (!reset)
            begin
                stp_err <= 1'b0;
            end
        else if (stp_chk_en)
            begin
                stp_err <= (sampled_bit == 1'b0);
            end
        else if (bit_cnt == 0)
            begin
                stp_err <= 1'b0;
            end
    end
endmodule