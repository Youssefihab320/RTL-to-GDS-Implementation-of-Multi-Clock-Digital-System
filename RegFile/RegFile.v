module RegFile #(
  parameter WIDTH = 8, 
            DEPTH = 16, 
            ADDR = 4 
)(
  // Inputs
  input    wire                CLK,                 // REF Clock
  input    wire                RST,                 // Active-low asynchronous reset
  input    wire                WrEn,                // Write enable
  input    wire                RdEn,                // Read enable
  input    wire   [ADDR-1:0]   Address,             // ADDR bit address for 8 registers
  input    wire   [WIDTH-1:0]  WrData,              // WIDTH bit write data
  
  // Outputs
  output   reg    [WIDTH-1:0]  RdData,              // WIDTH bit read data
  output   reg                 RdData_VLD,          // READ Data Valid
  output   wire   [WIDTH-1:0]  REG0,                // Config REG 0
  output   wire   [WIDTH-1:0]  REG1,                // Config REG 1
  output   wire   [WIDTH-1:0]  REG2,                // Config REG 2
  output   wire   [WIDTH-1:0]  REG3                 // Config REG 3
);

// For loop variable
integer i; 
  
// register file of 8 registers each of 16 bits width (8x16)
reg [WIDTH-1:0] regArr [DEPTH-1:0];    

always @(posedge CLK or negedge RST)
  begin
    if(!RST)  
      begin
	      RdData_VLD <= 1'b0;
	      RdData     <= 'b0;

        for (i=0 ; i < DEPTH ; i = i +1)
          begin
		        if(i==2)                          // Config Register for UART
              regArr[i] <= 'b100000_01;
		        else if (i==3)                    // Config Register for Div Ratio
              regArr[i] <= 'b0010_0000;
            else                              // Else Reset all other registers
              regArr[i] <= 'b0;		 
          end
     end
    else if (WrEn && !RdEn)                    // Register Write Operation
      begin
        regArr[Address] <= WrData;
      end
    else if (RdEn && !WrEn)                    // Register Read Operation
      begin    
        RdData <= regArr[Address];
	      RdData_VLD <= 1'b1;
      end  
    else
      begin
	      RdData_VLD <= 1'b0 ;
      end	 
  end

assign REG0 = regArr[0] ;
assign REG1 = regArr[1] ;
assign REG2 = regArr[2] ;
assign REG3 = regArr[3] ;

endmodule