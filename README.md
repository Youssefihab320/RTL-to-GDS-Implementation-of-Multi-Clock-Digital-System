# RTL-to-GDS-Implementation-of-Multi-Clock-Digital-System# RTL-to-GDS-Implementation-of-Multi-Clock-Digital-System

## Overview
This project is a low power configurable multi-clock digital system implemented in Verilog HDL. The system functions as a processing unit that receives external commands via a UART interface, performs necessary read/write or arithmetic operations, and safely transmits the computed results back through a UART transmitter. To ensure robust operation and prevent data loss across different clock domains, the design heavily incorporates Clock Domain Crossing (CDC) techniques, notably an asynchronous FIFO.

## Key Features
- Low Power & Configurable: Designed to operate efficiently as a multi-clock system.

- Command Execution: Receives commands via UART to perform targeted system functions.

- Processing Capabilities: Supports register read/write operations alongside ALU-based processing.

- Safe Data Transmission: Sends results through a UART transmitter utilizing an asynchronous FIFO.

- CDC Management: Safely handles different clock domains to prevent data loss.

## System Architecture
<img width="867" height="525" alt="image" src="https://github.com/user-attachments/assets/b3cc5cb9-1e7f-4682-b582-facfd922d2db" />

The top-level module (SYS_TOP) integrates several distinct hardware components:

- UART Interface: Contains an RX (Receiver) module to accept serial input (RX_IN) and a TX (Transmitter) module to drive serial output (TX_OUT) to the TestBench.

- System Controller (SYS_CTRL): The central FSM that orchestrates the flow of data, managing the Register File, ALU, and UART configurations.

- Register File (RegFile): Stores operands (Op_A, Op_B) for the ALU and outputs configuration settings (UART_Config) to the UART block.

- Arithmetic Logic Unit (ALU): Performs operations based on inputs from the Register File and control signals (FUN, EN), outputting the valid result (ALU_OUT) to the FIFO.

- Asynchronous FIFO (ASYNC FIFO): Bridges the core system domain and the UART transmission domain, buffering data (WR_DATA) from the system before it is read (RD_DATA) by the TX module.

## Clocking and Reset Management
The system utilizes advanced synchronization modules to manage distinct clock networks safely:

- Clock Domains: The system operates on a primary REF_CLK (driving the controller and registers) and a separate UART_CLK. The UART_CLK is processed by Clock Dividers based on a Div_Ratio to generate specific RX_CLK and TX_CLK signals.

- Clock Gating: To support low-power design, the ALU_CLK is dynamically toggled by a Clock Gating cell controlled by a Gate_EN signal.

- Data Synchronization: A Data Synchronizer ensures the safe transfer of incoming UART configuration data into the SYS_CTRL domain.

- Reset Synchronization: The global RST signal is safely aligned to the different internal clock domains using dedicated reset synchronizers (RST SYNC_1 and RST SYNC_2).
