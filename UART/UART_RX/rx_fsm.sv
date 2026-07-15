module rx_fsm (
    // Inputs
    input wire clk,                 // UART RX clock
    input wire reset,               // Asynchronous active low reset
    input wire par_en,              // Enable for the parity
    input wire RX_IN,               // Serial data input to RX module
    input wire [4:0] edge_cnt,      // Counter for edges of RX clock
    input wire [3:0] bit_cnt,       // Counter for the current bit recieved
    input wire par_err,             // Parity error signal
    input wire strt_glitch,         // Start bit glitch
    input wire stp_err,             // Stop bit error
    input wire [5:0] Prescale,      // Oversampling Prescale value (8 or 16 or 32)

    // Outputs
    output reg enable,              // Enable for edge_bit_counter module
    output reg data_samp_en,        // Enable for data_sampling module
    output reg par_chk_en,          // Enable for parity_check module
    output reg strt_chk_en,         // Enable for start_check module
    output reg stp_chk_en,          // Enable for stop_check module
    output reg deser_en,             // Enable for deserializer module
    output reg data_valid           // Data Valid signal
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

reg [3:0] frame_size;


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

// Sequenital current_state always
always @(posedge clk or negedge reset)
    begin
        if (!reset)
            begin
                current_state <= IDLE;
                data_valid <= 1'b0;
            end
        else 
            begin
                current_state <= next_state;
                data_valid <= data_valid;
            end
    end

// Combinational always for next_state logic
always @(*) 
    begin
        case (current_state)
            IDLE : begin
                        if (RX_IN == 0 && !par_err && !stp_err)                 // Start bit
                            begin
                                next_state = START;
                            end
                        else
                            begin
                                next_state = IDLE;
                            end
                   end 
            START : begin
                        if (bit_cnt != 4'b1)
                            begin
                                next_state = START;
                            end
                        else if (strt_glitch)           // If there is a start glitch return to IDLE
                            begin
                                next_state = IDLE;
                            end
                        else 
                            begin
                                next_state = DATA;
                            end
                    end
            DATA : begin
                        if (bit_cnt <= 8)
                            begin
                                next_state = DATA;
                            end
                        else if (par_en)                // Parity enabled => PARITY 
                            begin
                                next_state = PARITY;
                            end
                        else                            // Parity Disabled => STOP
                            begin
                                next_state = STOP;
                            end
                   end
            PARITY : begin
                        if (bit_cnt == 10)
                            begin
                                next_state = STOP;
                            end
                        else if (par_err)
                            begin
                                next_state = IDLE;
                            end
                        else
                            begin
                                next_state = PARITY;
                            end
                     end
            STOP : begin
                        if (bit_cnt != frame_size)
                            begin
                                next_state = STOP;
                            end
                        else if (RX_IN == 0 && !stp_err)
                            begin
                                next_state = START;
                            end
                        else 
                            begin
                                next_state = IDLE;
                            end
                   end
            default: next_state = IDLE;
        endcase
    end

// Combinational always for output logic
always @(*) 
    begin
        // Initial values for all outputs
        enable = 1'b0;
        data_samp_en = 1'b0;       
        par_chk_en = 1'b0; 
        strt_chk_en = 1'b0;   
        stp_chk_en = 1'b0; 
        deser_en = 1'b0;   
        data_valid = 1'b0;
            
        case (current_state)
            IDLE : begin
                        if (RX_IN == 0)
                            begin
                                data_samp_en = 1'b1;
                                enable = 1'b1;
                            end
                        else
                            begin
                                data_samp_en = 1'b0;
                                enable = 1'b0;
                            end
                   end 
            START : begin
                        enable = 1'b1;
                        data_samp_en = 1'b1;
                        // Enable Checking after sampled_bit is samplled correctly
                        if (bit_cnt == 0 && edge_cnt == ((Prescale >> 1) + 2))
                            strt_chk_en = 1'b1;             // Actively check for glitch during start bit
                        else 
                            strt_chk_en = 1'b0;
                    end
            DATA : begin
                        enable       = 1'b1;                // Keep edge counter running for data bits
                        data_samp_en = 1'b1;                // Keep data sampling running for data bits
                        // Enable Checking after sampled_bit is samplled correctly
                        if (bit_cnt !=9 && edge_cnt == ((Prescale >> 1) + 2))
                            deser_en = 1'b1;                // Enable deserializer to capture data
                        else 
                            deser_en = 1'b0;
                   end
            PARITY : begin
                        enable       = 1'b1;                // Keep edge counter running for parity bit
                        data_samp_en = 1'b1;                // Keep data sampling running for parity bit

                        // Enable Checking after sampled_bit is samplled correctly
                        if (bit_cnt == 9 && edge_cnt == ((Prescale >> 1) + 2))
                            par_chk_en = 1'b1;              // Enable parity check
                        else
                            par_chk_en = 1'b0;
                     end
            STOP : begin
                        // Enable Checking after sampled_bit is samplled correctly
                        if (bit_cnt == (frame_size - 1) && edge_cnt == ((Prescale >> 1) + 2))
                            stp_chk_en = 1'b1;              // Enable stop check
                        else
                            stp_chk_en = 1'b0;        

                        // Frame is Correct => Assert data_valid
                        // Note that this Condition checks for errors at the edge where those errors go High
                        if ((bit_cnt == frame_size) && !par_err && !stp_err )            
                            data_valid = 1'b1;
                        else
                            data_valid = 1'b0;

                        // When the frame is done disable the data_sampling and edge_bit_counter modules
                        if (bit_cnt != frame_size)
                            begin
                                enable = 1'b1;
                                data_samp_en = 1'b1;
                            end                  
                        else
                            begin
                                enable = 1'b0;
                                data_samp_en = 1'b0;
                            end    
                    end
            default: begin
                        // Default Values
                        enable         = 1'b0;
                        data_samp_en   = 1'b0;
                        par_chk_en     = 1'b0;
                        strt_chk_en    = 1'b0;
                        stp_chk_en     = 1'b0;
                        deser_en       = 1'b0;
                        data_valid = 1'b0;
                     end
        endcase
    end
endmodule