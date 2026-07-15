module edge_bit_counter (
    // Inputs
    input wire clk,                 // UART RX clock
    input wire reset,               // Asynchronous active low reset
    input wire enable,              // Enable for the edge_bit_counter module
    input wire par_en,              // To determine the frame size
    input wire [5:0] prescale,      // Oversampling Prescale value (8 or 16 or 32)

    // Outputs
    output reg [4:0] edge_cnt,      // Counter for edges of RX clock
    output reg [3:0] bit_cnt        // Counter for the current bit recieved
);
    
    reg [3:0] frame_size;           // 11 bit with parity & 10 bit w/o parity

// Always block for deciding frame size
always @(posedge clk or negedge reset) 
    begin
        if (!reset)
            begin
                frame_size <= 4'b0;
            end
        else if (bit_cnt == 0)
            begin
                if(par_en)
                    begin
                        frame_size <= 4'd11;
                    end
                else 
                    begin
                        frame_size <= 4'd10;
                    end
            end
    end

// Always block for counters
always @(posedge clk or negedge reset) 
    begin
        if (!reset)
            begin
                // Reseting both counter
                edge_cnt <= 0;
                bit_cnt <= 0;
            end
        else if (enable)
            begin
                if (edge_cnt != (prescale - 5'b1))
                    begin
                        // Increment edge_cnt untill (prescale - 1)
                        edge_cnt <= edge_cnt + 5'b1;
                    end
                else if (bit_cnt != frame_size)
                    begin
                        // At start of a new bit reset edge_cnt and increment bit_cnt
                        edge_cnt <= 0;
                        bit_cnt <= bit_cnt + 4'b1;
                    end
                else
                    begin
                        // Default Values
                        edge_cnt <= 0;
                        bit_cnt <= 0;
                    end
            end
        else
            begin
                edge_cnt <= 0;
                bit_cnt <= 0;
            end
    end
    
endmodule