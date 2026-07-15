module data_sampling (
    // Inputs
    input wire clk,                 // UART RX clock
    input wire reset,               // Asynchronous active low reset
    input wire RX_IN,               // Serial data input to RX module
    input wire data_samp_en,        // Enable for the data_sampling module
    input wire [4:0] edge_cnt,      // Counter for edges of RX clock
    input wire [5:0] prescale,      // Oversampling Prescale value (8 or 16 or 32)

    // Outputs
    output reg sampled_bit          // Sampled bit to be deserialized
);
    // 3 samples to detect the correct value for the sampled bit
    // Registers to store samples at the three mid-edge points
    reg sample_1, sample_2, sample_3;   

// Always block for sampling the 3 samples
always @(posedge clk or negedge reset) 
    begin
        if (!reset)
            begin
                sample_1 <= 1'b1;
                sample_2 <= 1'b1;
                sample_3 <= 1'b1;
            end
        else 
            begin
                if (data_samp_en)
                    begin
                        // If prescale = 8 then i will sample at 3 mid edges (3, 4 & 5)
                        if (edge_cnt == ((prescale >> 1) - 1)) 
                            begin
                                sample_1 <= RX_IN;
                            end
                        else if (edge_cnt == (prescale >> 1))
                            begin
                                sample_2 <= RX_IN;
                            end
                        else if (edge_cnt == ((prescale >> 1) + 1))
                            begin
                                sample_3 <= RX_IN;
                            end
                    end
            end
    end

// Always block for the output sampled_bit
// Combinational as it is supposed to be triggered once per bit
always @(*) 
    begin
        if(data_samp_en)
            begin
                // Majority voting between samples
                if ((sample_1 && sample_2) || (sample_1 && sample_3) || (sample_2 && sample_3))
                    begin
                        sampled_bit = 1'b1;
                    end 
                else 
                    begin
                        sampled_bit = 1'b0; 
                    end
            end
        else 
            begin
                sampled_bit = 1'b1;                 // IDLE state
            end     
    end
endmodule