module SYS_CTRL (
    // Inputs
    input wire CLK,                 // REF Clock
    input wire RST,                 // Active low asynchronous reset
    input wire [15:0] ALU_OUT,      // Output of ALU
    input wire ALU_OUT_Valid,       // Output Valid of ALU
    input wire [7:0] RF_RdData,     // Read data
    input wire RF_RdData_Valid,      // Valid read data
    input wire [7:0] RX_P_DATA,     // Output of UART RX (P_DATA)
    input wire RX_D_VLD,            // RX Data valid
    input wire FIFO_FULL,           // FIFO FULL flag

    // Outputs
    output reg [3:0] ALU_FUN,       // Input to ALU module to specify the operation
    output reg ALU_EN,              // ALU enable
    output reg CLK_EN,              // Clock Gate Enable
    output reg [3:0] RF_Address,    // RF_Address bus
    output reg RF_WrEn,             // Write enable
    output reg RF_RdEn,             // Read enable 
    output reg [7:0] RF_WrData,     // Write Data bus
    output reg [7:0] TX_P_DATA,     // UART TX Data
    output reg TX_D_VLD,            // UART TX Data valid
    output wire clk_div_en          // Clock Div enable
);

assign clk_div_en = 1'b1;           // Clock Div always enabled

// Temp Address (Comb)
reg [3:0] Addr_temp;

// Gray Encoding
typedef enum bit [3:0] { 
           IDLE = 4'b0000,
           WR_ADDR_RF = 4'b0001,
           WR_DATA_RF = 4'b0011,
           RD_ADDR_RF = 4'b0010,
           RD_DATA_RF = 4'b0110,
           WR_FIFO_RF = 4'b0111,
           OPERAND_A = 4'b0101,
           OPERAND_B = 4'b0100,
           ALU_OPCODE = 4'b1100,
           ALU_OPER = 4'b1101,
           WRITE_L = 4'b1111,                   // Note that: ALU_OUT is 16 bit while UART has only 8 bits 
           WRITE_M = 4'b1110                    // So we need to split the ALU_OUT on 2 frames
} state_e;

state_e current_state, next_state;

// State Transition
always @(posedge CLK or negedge RST)
    begin
        if (!RST)
            begin
                current_state <= IDLE;
            end
        else
            begin
                current_state <= next_state;
            end
    end

// Registering the RF_Address
always @(posedge CLK or negedge RST) 
    begin
        if (!RST)
            begin
                RF_Address <= 4'b0;
            end
        else
            begin
                RF_Address <= Addr_temp;
            end
    end

// Next state logic
always @(*) 
    begin
        case (current_state)
            IDLE :
                begin
                    if(RX_D_VLD)
                        case(RX_P_DATA)                              // Specify the operation to based on the command
                            8'hAA : next_state = WR_ADDR_RF;         // Write Data
                            8'hBB : next_state = RD_ADDR_RF;         // Read Data
                            8'hCC : next_state = OPERAND_A;          // Operation with two operands
                            8'hDD : next_state = ALU_OPCODE;         // Operation with no operands
                            default : next_state = IDLE;
                        endcase
                    else
                        next_state = IDLE;
                end

            WR_ADDR_RF :
                begin
                    if(RX_D_VLD)
                        next_state = WR_DATA_RF;
                    else
                        next_state = WR_ADDR_RF;
                end
            
            WR_DATA_RF : 
                begin
                    if(RX_D_VLD)
                        next_state = IDLE;
                    else
                        next_state = WR_DATA_RF;
                end

            RD_ADDR_RF :
                begin
                    if(RX_D_VLD)
                        next_state = RD_DATA_RF;
                    else
                        next_state = RD_ADDR_RF;
                end
            
            RD_DATA_RF : 
                begin
                    if(RF_RdData_Valid)                     // If Read data is valid go to FIFO state
                        next_state = WR_FIFO_RF;
                    else
                        next_state = RD_DATA_RF;
                end

            WR_FIFO_RF :
                begin
                    if(!FIFO_FULL)
                        next_state = IDLE;
                    else
                        next_state = WR_FIFO_RF;
                end

            OPERAND_A :
                begin
                    if(RX_D_VLD)
                        next_state = OPERAND_B;
                    else
                        next_state = OPERAND_A;
                end

            OPERAND_B :
                begin
                    if(RX_D_VLD)
                        next_state = ALU_OPCODE;
                    else
                        next_state = OPERAND_B; 
                end

            ALU_OPCODE : 
                begin
                    if(RX_D_VLD)
                        next_state = ALU_OPER;
                    else
                        next_state = ALU_OPCODE;
                end

            ALU_OPER:
                begin
                    if(ALU_OUT_Valid)                    // If ALU output is valid go to FIFO
                        next_state = WRITE_L;
                    else
                        next_state = ALU_OPER;    
                end

            WRITE_L :
                begin
                    if(!FIFO_FULL)
                        next_state = WRITE_M;
                    else 
                        next_state = WRITE_L;
                end

            WRITE_M :
                begin
                    if(!FIFO_FULL)
                        next_state = IDLE;
                    else 
                        next_state = WRITE_M;                
                end

            default: next_state = IDLE;
        endcase
    end

// Output logic
always @(*) 
    begin
        // Initial values
        ALU_FUN = 0;
        ALU_EN = 0;
        CLK_EN = 0;
        Addr_temp = RF_Address;
        RF_WrEn = 0;
        RF_RdEn = 0;
        RF_WrData = 0;
        TX_P_DATA = 0;
        TX_D_VLD = 0;

        case (current_state)
            IDLE :
                begin
                    if(RX_D_VLD && RX_P_DATA == 8'hCC)              // If it was Read or write in RegFile this is handled by next states
                        Addr_temp = 4'b0;                           // Operand A RF_Address (to be written)
                    else 
                        Addr_temp = 4'b1000;                        // Dummy RF_Address (next address after the configuration Regs)
                end 

            WR_ADDR_RF :
                begin
                    if(RX_D_VLD)
                        Addr_temp = RX_P_DATA[3:0];
                    else
                        Addr_temp = 4'b0;
                end

            WR_DATA_RF : 
                begin
                    if(RX_D_VLD)
                        begin
                            RF_WrData = RX_P_DATA;    
                            RF_WrEn = 1'b1;
                        end
                    else
                        begin
                            RF_WrData = 'b0;
                            RF_WrEn = 1'b0;
                        end
                end

            RD_ADDR_RF :
                begin
                    if(RX_D_VLD)
                        Addr_temp = RX_P_DATA[3:0];
                    else
                        Addr_temp = 4'b0;
                end

            RD_DATA_RF :
                begin
                    if(RF_RdData_Valid)
                        RF_RdEn = 1'b0;
                    else
                        RF_RdEn = 1'b1;
                end

            WR_FIFO_RF : 
                begin
                    if(!FIFO_FULL)
                        begin
                            TX_P_DATA = RF_RdData;
                            TX_D_VLD = 1'b1;
                        end
                    else
                        begin
                            TX_P_DATA = 'b0;
                            TX_D_VLD = 1'b0;
                        end
                end

            OPERAND_A :
                begin
                    if(RX_D_VLD)
                        begin
                            RF_WrData = RX_P_DATA;
                            RF_WrEn = 1'b1;
                            Addr_temp = 4'b1;                // RF_Address for Operand B
                            // Note that: RF_Address is sequential 
                        end
                    else
                        begin
                            RF_WrData = 'b0;
                            RF_WrEn = 1'b0;
                            Addr_temp = 4'b0;
                        end
                end

            OPERAND_B :
                begin
                    if(RX_D_VLD)
                        begin
                            RF_WrData = RX_P_DATA;
                            RF_WrEn = 1'b1;
                        end
                    else
                        begin
                            RF_WrData = 'b0;
                            RF_WrEn = 1'b0;
                        end
                end

            ALU_OPCODE :
                begin
                    if (RX_D_VLD)
                        begin
                            CLK_EN = 1'b1;                  // Enable Clock Gating
                            ALU_FUN = RX_P_DATA[3:0];
                            ALU_EN = 1'b1;
                        end
                    else
                        begin
                            CLK_EN = 1'b0;
                            ALU_FUN = 4'b0;
                            ALU_EN = 1'b0;
                        end
                end

            ALU_OPER :
                begin
                    if(ALU_OUT_Valid)
                        begin
                            CLK_EN = 1'b0;
                            ALU_EN = 1'b0;
                        end
                    else
                        begin
                            CLK_EN = 1'b1;
                            ALU_EN = 1'b1;
                        end
                end

            WRITE_L : 
                begin
                    if(!FIFO_FULL)
                        begin
                            TX_P_DATA = ALU_OUT[7:0];
                            TX_D_VLD = 1'b1;
                        end
                    else
                        begin
                            TX_P_DATA = 'b0;
                            TX_D_VLD = 1'b0;
                        end
                end

            WRITE_M : 
                begin
                    if(!FIFO_FULL)
                        begin
                            TX_P_DATA = ALU_OUT[15:8];
                            TX_D_VLD = 1'b1;
                        end
                    else
                        begin
                            TX_P_DATA = 'b0;
                            TX_D_VLD = 1'b0;
                        end
                end
            
            default: 
                begin
                    ALU_FUN = 0;
                    ALU_EN = 0;
                    CLK_EN = 0;
                    Addr_temp = RF_Address;
                    RF_WrEn = 0;
                    RF_RdEn = 0;
                    RF_WrData = 0;
                    TX_P_DATA = 0;
                    TX_D_VLD = 0; 
                end
        endcase
    end

endmodule