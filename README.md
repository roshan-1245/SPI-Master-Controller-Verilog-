# 16-Bit SPI Master Controller Using Verilog HDL

## Project Overview

This project presents the design and simulation of a **16-bit SPI (Serial Peripheral Interface) Master Controller** using Verilog HDL in Xilinx Vivado. The controller uses a Finite State Machine (FSM) to perform serial data transmission, transmitting data one bit at a time in MSB-first order.

A configurable clock divider is implemented to control the SPI clock frequency according to the selected divider parameter.

## Features

- 16-bit serial data transmission.
- MSB-first data transmission.
- FSM-based controller design.
- Active-low Chip Select (CS) signal.
- Configurable SPI clock divider.
- Verilog-based RTL implementation.
- Functional verification using a self-checking testbench.
- Simulation using Xilinx Vivado Simulator.

## Block Diagram
<img width="1887" height="955" alt="image" src="https://github.com/user-attachments/assets/d84784ab-ec86-41e6-987d-42d1d55c0b47" />


<img width="1011" height="500" alt="Screenshot 2026-11-01 195012" src="https://github.com/user-attachments/assets/f29ce7c2-bc40-443e-ac20-ef9f73a049ba" />


## RTL Design

The controller is implemented using Verilog HDL and consists of the following main signals:

| Signal | Description |
|---|---|
| `clk` | System clock input |
| `reset` | Active-high reset |
| `datain[15:0]` | 16-bit parallel input data |
| `spi_cs_l` | Active-low chip select |
| `spi_sclk` | SPI serial clock |
| `spi_data` | Serial data output (MOSI) |
| `counter` | Bit transmission counter |

## Configurable Clock Divider

The SPI clock frequency is controlled using the `CLK_DIV` parameter.

The relationship is:

\[
f_{SCLK}=\frac{f_{clk}}{2\times CLK\_DIV}
\]

For a 100 MHz system clock:

| CLK_DIV | SPI Clock Frequency |
|---:|---:|
| 1 | 50 MHz |
| 5 | 10 MHz |
| 50 | 1 MHz |
| 500 | 100 kHz |

The divider value can be modified during module instantiation.

## Simulation and Verification

The design is verified using a Verilog testbench in Xilinx Vivado Simulator.

**Test Configuration:**

- System Clock: 100 MHz
- Input Data: `16'hA5F0`
- Data Width: 16 bits
- Transmission Order: MSB First

**Simulation Result:**

| Parameter | Result |
|---|---|
| Input Data | `A5F0` |
| Received Data | `A5F0` |
| Total Bits | 16 |
| Verification | PASS |

## Simulation Waveform

<!-- Replace this placeholder with your Vivado simulation waveform screenshot -->

![SPI Master Simulation Waveform](docs/images/spi_master_waveform.png)

## Project Structure

```text
SPI-Master-Controller-Verilog/
│
├── RTL/
│   └── spi_state.v
│
├── Testbench/
│   └── tb_spi_state.v
│
├── docs/
│   └── images/
│       ├── spi_master_block_diagram.png
│       └── spi_master_waveform.png
│
└── README.md
```

## Tools Used

- **HDL:** Verilog
- **Design and Simulation:** Xilinx Vivado
- **Verification:** Vivado Simulator
- **Design Methodology:** Finite State Machine (FSM)

## Future Improvements

- Support for SPI Modes 0, 1, 2, and 3.
- Configurable data width.
- Dynamic clock divider selection.
- SPI slave communication.
- FPGA hardware implementation.



---

*This project demonstrates RTL design, FSM implementation, serial communication, clock division, and functional verification using Verilog HDL.*
