module CLK_GATE (
    input wire CLK, 				// REF Clock
	input wire CLK_EN,				// Clock enable
	output wire GATED_CLK			// Output Gated Clock
);

reg latched_en;						// Latched Enable

// AND Gate (Enable & CLK)
assign GATED_CLK = latched_en & CLK;		

// LATCH
always @(CLK or CLK_EN) 
	begin
		if (!CLK)
		  	begin	
				latched_en <= CLK_EN;
		  	end	  
    end

// For Synthesis
/*
TLATNCAX12M U0_TLATNCAX12M (
					.E(CLK_EN),
					.CK(CLK),
					.ECK(GATED_CLK)
);
*/

endmodule
