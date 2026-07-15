module mux (
    // Inputs
    input wire [1:0] mux_sel,        // MUX select from the FSM
    input wire start_bit,            // Start bit (1'b0)
    input wire stop_bit,             // Stop bit (1'b1)
    input wire ser_data,             // Serial data from the serializer
    input wire par_bit,              // Parity bit from the parity calculator

    // Outputs
    output reg TX_OUT                // Final serial output
);

always @(*) 
    begin
        case (mux_sel)
            2'b00 : TX_OUT = start_bit;
            2'b01 : TX_OUT = ser_data;
            2'b10 : TX_OUT = par_bit;
            2'b11 : TX_OUT = stop_bit;
            default: TX_OUT = stop_bit;             // Default high
        endcase
    end

endmodule