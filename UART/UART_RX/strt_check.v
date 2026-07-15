module strt_check (
    // Inputs
    input wire clk,                 // UART RX clock
    input wire reset,               // Asynchronous active low reset
    input wire strt_chk_en,         // Enable for start_check module
    input wire sampled_bit,         // Sampled bit to be deserialized
    input wire [3:0] bit_cnt,

    // Outputs
    output reg strt_glitch         // Start bit glitch
);

always @(posedge clk or negedge reset) 
    begin
        if (!reset)
            begin
                strt_glitch <= 1'b0;
            end
        else if (strt_chk_en)
            begin
                // If sampled bit not equal to 0 after majority voting then this is a start gltich
                strt_glitch <= (sampled_bit == 1'b1);           
            end
        else if (bit_cnt == 1)
            begin
                strt_glitch <= 1'b0;
            end
    end

endmodule