`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2026 10:13:43
// Design Name: 
// Module Name: UART
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
////////////////////////////////////////////////////////////////////////////////vectored
module UART(
input [7:0] data,
input start,
input rst,
input clk,
output reg TX,
output reg busy
);  

reg [1:0] STATE;

localparam IDLE  = 2'b00;
localparam START = 2'b01;
localparam DATA  = 2'b10;
localparam STOP  = 2'b11;    

reg [7:0] data_reg;
reg [13:0] baud_counter;
reg [3:0] bit_counter;

always @(posedge clk or posedge rst) begin 

    if(rst) begin   
        baud_counter <= 14'b0;
        bit_counter  <= 4'b0;
        data_reg     <= 8'b0;
        TX           <= 1'b1;
        busy         <= 1'b0;
        STATE        <= IDLE;
    end 

    else begin

        case(STATE)

            IDLE : begin
                if(start) begin 
                    data_reg <= data;
                    STATE <= START;
                    busy <= 1'b1;
                    baud_counter <= 0;
                    bit_counter <= 0;
                end 
                else begin
                    STATE <= IDLE;
                    TX <= 1'b1;
                    busy <= 1'b0;
                end
            end

            START : begin 
                TX <= 1'b0;
                busy <= 1'b1;

                if (baud_counter == 5207) begin
                    STATE <= DATA;
                    baud_counter <= 0;
                    bit_counter <= 0;
                end
                else begin
                    baud_counter <= baud_counter + 1;
                end  
            end

            DATA : begin

                TX <= data_reg[0];
                busy <= 1'b1;

                if (baud_counter == 5207) begin

                    baud_counter <= 0;

                    if (bit_counter == 7) begin
                        STATE <= STOP;
                        bit_counter <= 0;
                    end
                    else begin
                        bit_counter <= bit_counter + 1;
                        data_reg <= data_reg >> 1;
                    end

                end
                else begin
                    baud_counter <= baud_counter + 1;
                end

            end

            STOP : begin

                TX <= 1'b1;
                busy <= 1'b1;

                if (baud_counter == 5207) begin
                    STATE <= IDLE;
                    baud_counter <= 0;
                    busy <= 1'b0;
                end
                else begin
                    baud_counter <= baud_counter + 1;
                end

            end

            default : begin
                STATE <= IDLE;
                TX <= 1'b1;
                busy <= 1'b0;
                baud_counter <= 0;
                bit_counter <= 0;
            end

        endcase
    end
end

endmodule