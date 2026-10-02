`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2026 10:16:32
// Design Name: 
// Module Name: UARTtb
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


module UARTtb;

reg [7:0] data;
reg start;
reg rst;
reg clk;

wire TX;
wire busy;

UART uut (
    .data(data),
    .start(start),
    .rst(rst),
    .clk(clk),
    .TX(TX),
    .busy(busy)
);

// 50 MHz clock
always #10 clk = ~clk;

initial begin

    // Initial values
    clk   = 0;
    rst   = 1;
    start = 0;
    data  = 8'b10100101;

    // Hold reset
    #100;

    // Release reset
    rst = 0;

    // Wait a little
    #100;

    // Give START a pulse
    start = 1;
    #20;             // one clock period
    start = 0;

    // Wait for complete UART transmission
    #1100000;

    $finish;

end

endmodule