module ClkDiv #(
    parameter DIV_RATIO_WIDTH = 8
)(
    // Inputs
    input wire i_ref_clk,                                   // Reference Clock
    input wire i_rst_n,                                     // Active Low Asynchronous Reset
    input wire i_clk_en,                                    // Clock Divider Block Enable
    input wire [DIV_RATIO_WIDTH - 1 : 0] i_div_ratio,       // The divided ratio (integer value)

    // Outputs
    output wire o_div_clk                                   // Divided Output Clock
);

// Internal counter to track clock cycles
reg [7:0] counter;

// Internal Divided clock
reg internal_div_clk;

// Internal signal to enable the clock divider based on corner cases
wire clk_div_en_internal;

// Corner Case Check: i_div_ratio must not be 0 or 1
// CIK_DIV_EN = I_clk_en && (I_div_ratio != Zero) && (I_div_ratio != One)
assign clk_div_en_internal = i_clk_en && (i_div_ratio != 8'd0) && (i_div_ratio != 8'd1);

// Internal signals for operation of clk divider (Even Clk_Div)
wire [7:0] half_togg;
assign half_togg = i_div_ratio >> 1;

// Handling Odd Clk_Div
wire odd = i_div_ratio[0];              // Where lsb equal to 1 for odd numbers
wire [7:0] half_togg_odd;
assign half_togg_odd = i_div_ratio - half_togg; 

// Flag that gets toggled for Odd case
wire flag_odd;
assign flag_odd = internal_div_clk;     // Handles corner case when i_div_ratio is changed mid high o_div_clk

// Handling the case of reseting, div_ratio = 0 or 1 & clk_div disabled
assign o_div_clk = (!i_rst_n || !clk_div_en_internal) ? i_ref_clk : internal_div_clk;

// Handling the case going from high i_div_ratio to lower one without the counter latching
reg [7:0] temp_div_ratio;

always @(posedge i_ref_clk or negedge i_rst_n) 
    begin
        if(!i_rst_n)
            begin
                internal_div_clk <= 0;
                counter <= 8'd0;
                temp_div_ratio <= 0;
            end
        else if (clk_div_en_internal)
            begin
                temp_div_ratio <= i_div_ratio;                       // Registering the value of i_div_ratio when if it is changed mid counting                 
                if (temp_div_ratio != i_div_ratio)
                    begin
                        counter <= 8'd0;
                    end
                else if (!odd && counter == (half_togg - 1))         // For even divisions, toggle the output after half the count to get 50% duty cycle
                    begin
                        internal_div_clk <= ! internal_div_clk;
                        counter <= 8'd0;
                    end
                else if (odd)
                    begin
                        // The following logic ensures the low cycle is higher by one than the high cycle
                        if ((counter == (half_togg - 1) && flag_odd) || (counter == (half_togg_odd - 1) && !flag_odd))
                            begin
                                internal_div_clk <= !internal_div_clk;
                                counter <= 8'd0;
                            end
                        else
                            counter <= counter + 1;
                    end
                else 
                    counter <= counter + 1;
            end
        else 
            begin
                // Clock divider is disabled (i_clk_en = 0 or i_div_ratio = 0 or 1)
                // Reset internal states. These are irrelevant for the final o_div_clk
                // because the assign statement will pass i_ref_clk instead.
                internal_div_clk <= 0;
                counter <= 8'd0;
                temp_div_ratio <= 0;
            end
    end
endmodule
