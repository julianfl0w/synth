//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2016 06:51:35 PM
// Design Name: 
// Module Name: i2s_tx_tb
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
`timescale 1ns / 100ps

module i2s_tx_tb(
    );

reg clk12Mhz = 0;
reg [31:0] left_chan = 0;
reg [31:0] right_chan = 32'hFFFFFFFF;

always #1 clk12Mhz = ~clk12Mhz;

i2s_tx i2s_tx_i(
	.clk12Mhz(clk12Mhz),
	.lrclk(lrclk),
	.bclk(bclk),
	.sdata(sdata),
	.left_chan(left_chan), 
	.right_chan(right_chan)
);

endmodule