module uart_fsm (
    // Inputs
    input wire clk,
    input wire reset,
    input wire data_valid,
    input wire ser_done,
    input wire par_en,

    // Outputs
    output reg ser_en,
    output reg busy,
    output reg [1:0] mux_sel
);
    
// Gray Encoding
typedef enum bit [2:0] { 
           IDLE = 3'b000,
           START = 3'b001,
           DATA = 3'b011,
           PARITY = 3'b010,
           STOP = 3'b110
} state_e;

// States
state_e current_state, next_state;

// Sequenital current_state always
always @(posedge clk or negedge reset)
    begin
        if (!reset)
            begin
                current_state <= IDLE;
            end
        else 
            begin
                current_state <= next_state;
            end
    end

// Combinational always for next_state logic and output logic
always @(*) 
    begin
        case (current_state)
            IDLE : begin
                        ser_en = 0;
                        busy = 0;
                        mux_sel = 2'b11;
                        if (data_valid)
                            begin
                                next_state = START;
                            end
                        else 
                            begin
                                next_state = IDLE;
                            end
                   end 
            START : begin
                        ser_en = 0;
                        busy = 1;
                        mux_sel = 2'b00;
                        next_state = DATA;
                    end
            DATA : begin
                        busy = 1;
                        mux_sel = 2'b01;
                        ser_en = 1;
                        if (ser_done)
                            begin
                                if (par_en)
                                    begin
                                        next_state = PARITY;
                                    end
                                else
                                    begin
                                        next_state = STOP;
                                    end        
                            end
                        else 
                            begin
                                next_state = DATA;
                            end
                   end
            PARITY : begin
                        ser_en = 0;
                        mux_sel = 2'b10;
                        busy = 1;
                        next_state = STOP;
                     end
            STOP : begin
                        ser_en = 0;
                        mux_sel = 2'b11;
                        busy = 1;
                        next_state = IDLE;
                   end
            default: begin
                        ser_en = 0;
                        mux_sel = 2'b11;
                        busy = 0;
                        next_state = IDLE;               
                     end
        endcase
    end
endmodule