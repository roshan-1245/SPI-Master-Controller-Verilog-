`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 17:22:27
// Design Name: 
// Module Name: spi_state
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

module spi_state(
    input wire clk,
    input wire reset,
    input wire [15:0] datain,

    output wire spi_cs_l,
    output wire spi_sclk,
    output wire spi_data,
    output wire [4:0] counter
);

// Internal registers
reg MOSI;
reg [4:0] count;
reg cs_l;
reg sclk;
reg [2:0] state;

// FSM states
localparam IDLE  = 3'd0;
localparam START = 3'd1;
localparam TRANS = 3'd2;

// Main SPI state machine
always @(posedge clk or posedge reset)
begin
    if (reset) begin
        MOSI  <= 1'b0;
        count <= 5'd16;
        cs_l  <= 1'b1;
        sclk  <= 1'b0;
        state <= IDLE;
    end
    else begin
        case (state)

            // State 0: Idle
            IDLE: begin
                sclk  <= 1'b0;
                cs_l  <= 1'b1;
                state <= START;
            end

            // State 1: Start transmission
            START: begin
                sclk  <= 1'b0;
                cs_l  <= 1'b0;
                MOSI  <= datain[count-1];
                count <= count - 1'b1;
                state <= TRANS;
            end

            // State 2: Transmit data
            TRANS: begin
                sclk <= 1'b1;

                if (count > 0) begin
                    state <= START;
                end
                else begin
                    count <= 5'd16;
                    state <= IDLE;
                end
            end

            // Default state
            default: begin
                state <= IDLE;
                sclk  <= 1'b0;
                cs_l  <= 1'b1;
                count <= 5'd16;
                MOSI  <= 1'b0;
            end

        endcase
    end
end

// Output assignments
assign spi_cs_l = cs_l;
assign spi_sclk = sclk;
assign spi_data = MOSI;
assign counter  = count;

endmodule