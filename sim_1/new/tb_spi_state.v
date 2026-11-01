`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 17:25:25
// Design Name: 
// Module Name: tb_spi_state
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////




module tb_spi_state;

// Testbench signals
reg clk;
reg reset;
reg [15:0] datain;

wire spi_cs_l;
wire spi_sclk;
wire spi_data;
wire [4:0] counter;

// Expected received data
reg [15:0] received_data;
integer bit_index;

// Instantiate DUT
spi_state uut (
    .clk(clk),
    .reset(reset),
    .datain(datain),
    .spi_cs_l(spi_cs_l),
    .spi_sclk(spi_sclk),
    .spi_data(spi_data),
    .counter(counter)
);

// Generate 100 MHz clock
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

// Apply test inputs
initial begin

    reset = 1'b1;
    datain = 16'hA5F0;

    received_data = 16'b0;
    bit_index = 0;

    // Reset duration
    #20;
    reset = 1'b0;

    // Wait for transmission
    wait (bit_index == 16);

    #20;

    // Display results
    $display("--------------------------------");
    $display("SPI TRANSMISSION COMPLETED");
    $display("Input Data    = %h", datain);
    $display("Received Data = %h", received_data);
    $display("Total Bits    = %0d", bit_index);

    if (received_data == datain)
        $display("TEST PASSED!");
    else
        $display("TEST FAILED!");

    $display("--------------------------------");

    $finish;
end

// Capture MOSI data on SCLK rising edge
always @(posedge spi_sclk) begin

    if (!spi_cs_l && bit_index < 16) begin

        received_data[15-bit_index] = spi_data;

        bit_index = bit_index + 1;

        $display("Time=%0t | Bit=%0d | MOSI=%b | SCLK=%b",
                 $time, bit_index, spi_data, spi_sclk);
    end

end

// Simulation timeout
initial begin
    #5000;
    $display("ERROR: Simulation timeout!");
    $finish;
end

endmodule

