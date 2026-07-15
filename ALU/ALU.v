module ALU #( 
  parameter OPER_WIDTH = 8,
            OUT_WIDTH = OPER_WIDTH * 2,
            FUN_WIDTH = 4
)(
  // Inputs
  input wire                  CLK,            // ALU Clock
  input wire                  RST,            // Active-low asynchronous reset
  input wire [OPER_WIDTH-1:0] A,              // Operand A
  input wire [OPER_WIDTH-1:0] B,              // Operand B
  input wire                  EN,             // ALU Enable
  input wire [FUN_WIDTH - 1 : 0] ALU_FUN,     // ALU FUN 
  
  // Outputs
  output reg [OUT_WIDTH-1:0]  ALU_OUT,        // ALU Output
  output reg                  OUT_VALID       // ALU Output Valid
);
  
//internal_signals  
reg [OUT_WIDTH-1:0] ALU_OUT_Comb;             // Combinational ALU Output
reg                 OUT_VALID_Comb;           // Combinational ALU Output Valid 
  
// Registering Outputs
always @(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
        ALU_OUT   <= 'b0 ;
        OUT_VALID <= 1'b0 ;	
      end
    else 
      begin  
        ALU_OUT   <= ALU_OUT_Comb ;
        OUT_VALID <= OUT_VALID_Comb ;
      end	
  end  

// Combinational always logic
always @(*)
  begin
    OUT_VALID_Comb = 1'b0 ;
    ALU_OUT_Comb   = 'b0 ;
    if(EN)
      begin   
	      OUT_VALID_Comb = 1'b1 ;
        case (ALU_FUN) 
          4'b0000:                        // Addition
              begin
                ALU_OUT_Comb = A+B;
              end
          4'b0001:                        // Subtraction
              begin
                ALU_OUT_Comb = A-B;
              end
          4'b0010:                        // Multiplication
              begin
                ALU_OUT_Comb = A*B;
              end
          4'b0011:                        // Division
              begin
                ALU_OUT_Comb = A/B;
              end
          4'b0100:                        // AND
              begin
                ALU_OUT_Comb = A & B;
              end
          4'b0101:                        // OR 
              begin
                ALU_OUT_Comb = A | B;
              end
          4'b0110:                        // NAND
              begin
                ALU_OUT_Comb = ~ (A & B);
              end
          4'b0111:                        // NOR
              begin
                ALU_OUT_Comb = ~ (A | B);
              end     
          4'b1000:                        // XOR
              begin
                ALU_OUT_Comb =  (A ^ B);
              end
          4'b1001:                        // XNOR
              begin
                ALU_OUT_Comb = ~ (A ^ B);
              end           
          4'b1010:                        // Equal
              begin
                if (A==B)
                  ALU_OUT_Comb = 'b1;
                else
                  ALU_OUT_Comb = 'b0;
              end
          4'b1011:                       // Greater
              begin
                if (A>B)
                  ALU_OUT_Comb = 'b10;
                else
                  ALU_OUT_Comb = 'b0;
              end 
          4'b1100:                       // Less
              begin
                if (A<B)
                  ALU_OUT_Comb = 'b11;
                else 
                  ALU_OUT_Comb = 'b0;
              end     
          4'b1101:                       // Shift right
              begin
                ALU_OUT_Comb = A>>1;
              end
          4'b1110:                      // Shift left
              begin 
                ALU_OUT_Comb = A<<1;
              end
          default:                      // NOP 
              begin
              ALU_OUT_Comb = 'b0;
              end
          endcase
      end
    else
      begin
	    OUT_VALID_Comb = 1'b0 ;
      end   
  end  
  
endmodule