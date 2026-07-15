module deserializer #(
    parameter DATA_WIDTH = 8
)(
    // Inputs
    input wire clk,                 // UART RX clock
    input wire reset,               // Asynchronous active low reset
    input wire sampled_bit,         // Sampled bit to be deserialized
    input wire deser_en,            // Enable for deserializer module

    // Outputs
    output reg [7:0] P_DATA         // Output Parallel data of the deserializer
);
    reg [2:0] bit_count;

always @(posedge clk or negedge reset) 
    begin
        if (!reset)
            begin
                P_DATA <= 8'b0; 
                bit_count <= 3'b0;
            end
        else if (deser_en && bit_count <= 7)
            begin
                P_DATA <= {sampled_bit, P_DATA[7:1]};               // shift right, insert new bit
                bit_count <= bit_count + 3'b1;
            end
    end
endmodule