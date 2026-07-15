`timescale 1ns / 1ps

module UART_RX_tb ();

    // DUT Inputs
    reg CLK_tb;
    reg RST_tb;
    reg RX_IN_tb;
    reg [5:0] Prescale_tb;
    reg PAR_EN_tb;
    reg PAR_TYP_tb;

    // DUT Outputs
    wire data_valid_tb;
    wire [7:0] P_DATA_tb;
    wire Parity_Error_tb;
    wire Stop_Error_tb;

    // Checking Operation regs
    reg [4:0] operation_count;
    reg TX_CLK;

    // Clock Parameters
    parameter TX_CLK_PERIOD  = 8680;

    // Clock Generation
    always #(TX_CLK_PERIOD / (2 * Prescale_tb)) CLK_tb = ~ CLK_tb;
    always #(TX_CLK_PERIOD / 2) TX_CLK = ~ TX_CLK;

// Instantiating the DUT
UART_RX DUT (
                .CLK(CLK_tb),
                .RST(RST_tb),
                .RX_IN(RX_IN_tb),
                .Prescale(Prescale_tb),
                .PAR_EN(PAR_EN_tb),
                .PAR_TYP(PAR_TYP_tb),
                .data_valid(data_valid_tb),
                .P_DATA(P_DATA_tb),
                .Parity_Error(Parity_Error_tb),
                .Stop_Error(Stop_Error_tb)
);

initial 
    begin
        // System Functions
        $dumpfile("UART_RX.vcd") ;       
        $dumpvars;
        
        // Starting Simulation
        $display("----------------------------");               // Separator to indicate Simulation start
        $display("Starting Simulation for UART_RX");

        // Initialize signals
        initialize();

        Prescale_tb = 8;
        $display("Prescale Value = %0d",Prescale_tb);

        // Reset 
        reset();

        // Note that: First two frames (test cases) aren't Consecutive
        // Test Case 1
        $display("Test Case 1: No Parity with Data 0x26");      // 0010 0110
        send_uart_frame(8'h26, 1'b0, 1'b0, 1'b0, 1'b0);
	    #TX_CLK_PERIOD;

        // Test Case 2
        $display("Test Case 2: Even Parity with Data 0x73");      // 0111 0011
        send_uart_frame(8'h73, 1'b1, 1'b0, 1'b0, 1'b0);

        // Sending Consecutive Frames
        // Test Case 3
        $display("Test Case 3: Odd Parity with Data 0xF5 Consecutive to the Previous Frame");
        send_uart_frame(8'hf5, 1'b1, 1'b1, 1'b0, 1'b0);

        // Test Case 4
        $display("Test Case 4: Even Parity with Data 0xCD & Inserting Par_bit Error");
        send_uart_frame(8'hcd, 1'b1, 1'b0, 1'b1, 1'b0);

        // Test Case 5
        $display("Test Case 5: No Parity with Data 0xAC & Inserting Stop_bit Error");
        send_uart_frame(8'hac, 1'b1, 1'b0, 1'b0, 1'b1);

        // Test Case 6 
        $display("Test Case 6: Odd Parity with Data 0xDB");         // 1101 1011
        send_uart_frame(8'hdb, 1'b1, 1'b1, 1'b0, 1'b0);

        // Test Case 7 
        $display("Test Case 7: Even Parity with Data 0xFF");
        send_uart_frame(8'hff, 1'b1, 1'b0, 1'b0, 1'b0);

        #(6*TX_CLK_PERIOD);

        Prescale_tb = 16;
        $display("Prescale Value = %0d",Prescale_tb);

        // Test Case 8
        $display("Test Case 8: No Parity with Data 0x26");      // 0010 0110
        send_uart_frame(8'h26, 1'b0, 1'b0, 1'b0, 1'b0);
	    #TX_CLK_PERIOD;

        // Test Case 9
        $display("Test Case 9: Even Parity with Data 0x73");      // 0111 0011
        send_uart_frame(8'h73, 1'b1, 1'b0, 1'b0, 1'b0);

        // Sending Consecutive Frames
        // Test Case 10
        $display("Test Case 10: Odd Parity with Data 0xF5 Consecutive to the Previous Frame");
        send_uart_frame(8'hf5, 1'b1, 1'b1, 1'b0, 1'b0);

        // Test Case 11
        $display("Test Case 11: Even Parity with Data 0xCD & Inserting Par_bit Error");
        send_uart_frame(8'hcd, 1'b1, 1'b0, 1'b1, 1'b0);

        // Test Case 12
        $display("Test Case 12: No Parity with Data 0xAC & Inserting Stop_bit Error");
        send_uart_frame(8'hac, 1'b1, 1'b0, 1'b0, 1'b1);

        // Test Case 13
        $display("Test Case 14: Odd Parity with Data 0xDB");         // 1101 1011
        send_uart_frame(8'hdb, 1'b1, 1'b1, 1'b0, 1'b0);

        // Test Case 14
        $display("Test Case 14: Even Parity with Data 0xFF");
        send_uart_frame(8'hff, 1'b1, 1'b0, 1'b0, 1'b0);

        #(6*TX_CLK_PERIOD);

        Prescale_tb = 32;
        $display("Prescale Value = %0d",Prescale_tb);

        // Test Case 15
        $display("Test Case 15: No Parity with Data 0x26");      // 0010 0110
        send_uart_frame(8'h26, 1'b0, 1'b0, 1'b0, 1'b0);
	    #TX_CLK_PERIOD;

        // Test Case 16
        $display("Test Case 16: Even Parity with Data 0x73");      // 0111 0011
        send_uart_frame(8'h73, 1'b1, 1'b0, 1'b0, 1'b0);

        // Sending Consecutive Frames
        // Test Case 17
        $display("Test Case 17: Odd Parity with Data 0xF5 Consecutive to the Previous Frame");
        send_uart_frame(8'hf5, 1'b1, 1'b1, 1'b0, 1'b0);

        // Test Case 18
        $display("Test Case 18: Even Parity with Data 0xCD & Inserting Par_bit Error");
        send_uart_frame(8'hcd, 1'b1, 1'b0, 1'b1, 1'b0);

        // Test Case 19
        $display("Test Case 19: No Parity with Data 0xAC & Inserting Stop_bit Error");
        send_uart_frame(8'hac, 1'b1, 1'b0, 1'b0, 1'b1);

        // Test Case 20
        $display("Test Case 20: Odd Parity with Data 0xDB");         // 1101 1011
        send_uart_frame(8'hdb, 1'b1, 1'b1, 1'b0, 1'b0);

        // Test Case 21
        $display("Test Case 21: Even Parity with Data 0xFF");
        send_uart_frame(8'hff, 1'b1, 1'b0, 1'b0, 1'b0);

        // Test Case 22
        $display("Test Case 22: Verifying Start Glitch");
        strt_glitch();

        #TX_CLK_PERIOD;
        $stop;
    end


// Tasks
task initialize;
    begin
        TX_CLK = 0;
        CLK_tb = 0;
        RX_IN_tb = 1;
        PAR_EN_tb = 0;
        PAR_TYP_tb = 0;
        operation_count = 0;
    end
endtask

task reset;
    begin
       RST_tb = 1'b1;
       #(TX_CLK_PERIOD / Prescale_tb);
       RST_tb = 1'b0;
       #(TX_CLK_PERIOD / Prescale_tb);
       RST_tb = 1'b1;
       if (P_DATA_tb == 0 & data_valid_tb == 1'b0)
            $display("Reset Done");
       else 
            $display("Reset Failed");
    end
endtask

task send_bit;
    input bit_value;
    begin
       RX_IN_tb = bit_value;
       #TX_CLK_PERIOD; 
    end
endtask

function automatic calculate_parity;
    input [7:0] in_data;
    reg par_bit;
    begin
        if (PAR_EN_tb)
            begin
                if (PAR_TYP_tb) 
                    begin 
                        // Odd parity: result is 1 if the number of 1s is even
                        par_bit = ~(^in_data);
                    end 
                else 
                    begin
                        // Even parity: result is 1 if the number of 1s is odd
                        par_bit = ^(in_data);
                    end
            end
        calculate_parity = par_bit;
    end
endfunction

task send_uart_frame;
    input [7:0] tx_data;
    input tx_par_en;
    input tx_par_typ;
    input corner_case_par;
    input corner_case_stp;
    reg calculated_parity_bit;
    integer i;
    begin
        operation_count = operation_count + 1;
        PAR_EN_tb = tx_par_en;
        PAR_TYP_tb = tx_par_typ;

        $display("Start Transmitting UART Frame");

        // Send Start bit
        send_bit (1'b0);

        // Send 8 bit data (LSB first)
        for (i = 0; i < 8; i = i + 1)
            begin
                send_bit (tx_data[i]);
            end
        
        // Send Parity bit if enabled
        if (tx_par_en)
            begin
                calculated_parity_bit = calculate_parity (tx_data);
                if (corner_case_par)
                    begin
                        send_bit (~calculated_parity_bit);          // Injection of wrong parity bit
                        $display("Error in parity bit returning to IDLE State");
                    end
                else
                    begin
                        send_bit (calculated_parity_bit);
                    end
            end

        
        // Send Stop bit 
        if (corner_case_stp)
            begin
                send_bit (1'b0);                                    // Injection of wrong stop bit
                $display("Error in stop bit returning to IDLE State");
            end
        else
            begin
                send_bit (1'b1);
            end
        
        if ((!corner_case_stp && !corner_case_par))
            begin
                // Checking Operation
                if (P_DATA_tb == tx_data && !Stop_Error_tb && !Parity_Error_tb)
                    $display("Test Case %0d Succeeded", operation_count);
                else
                    $display("Test Case %0d Failed", operation_count);
            end
        else
            begin
                $display("Error Bit is injected");
                if (!data_valid_tb)  
                        $display("Test Case %0d Succeeded", operation_count);
                else
                        $display("Test Case %0d Failed", operation_count);
                
            end

        $display("----------------------------");               // Separator between testcases
    end
endtask

task strt_glitch;
    begin
        operation_count = operation_count + 1;

        RX_IN_tb = 1'b1;
        #(TX_CLK_PERIOD / Prescale_tb);
        RX_IN_tb = 1'b0;
        #(TX_CLK_PERIOD / Prescale_tb);
        RX_IN_tb = 1'b1;
        #(TX_CLK_PERIOD / Prescale_tb);
         
        if (!data_valid_tb)
            $display("Test Case %0d Succeeded", operation_count);
        else
            $display("Test Case %0d Failed", operation_count);
    end
endtask

endmodule