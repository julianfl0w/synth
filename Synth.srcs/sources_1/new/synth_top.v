`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: JUIXXXE
//////////////////////////////////////////////////////////////////////////////////
`define CHANNELDEPTH 16
module synth_top(
     input clk,          
     input btnU,
     input btnC,          
     input btnR,
     input btnL,          
     input btnD,
     input [15:0] sw,
     output [15:0] led,
     
     output reg dp = 0,
     output [6:0] seg,
     output reg [3:0] an = 4'b0,
     
     output reg SD_2518 = 1'b1,   // Shut down - active low
     output wire bclk_2518,       // bit clock output for 2518 
     output wire lrclk_2518,      // lrclk aka word clock for 2518
     output wire sdata_2518,      // serial data output for 2518    
     output wire mclk_2518        // master clock for 2518
);
assign led = sw;
assign seg[6:5] = 2'b0;
assign seg[4] = btnU;
assign seg[3] = btnD;
assign seg[2] = btnL;
assign seg[1] = btnR;
assign seg[0] = btnC;

wire signed [`CHANNELDEPTH -1:0] sawtooth;
oscillator Osc1(
    .mclk(mclk_2518),
    .lrclk(lrclk_2518),
    .sawtooth(sawtooth)
);
i2s_tx i2stx(
    .bclk(bclk_2518),
    .lrclk(lrclk_2518),
    .mclk(mclk_2518),
    .sdata(sdata_2518),
    .left_chan(sawtooth),
    .right_chan(sawtooth)
);
clk_div sclkdiv(
    .clk(clk),
    .mclk(mclk_2518),
    .bclk(bclk_2518),
    .lrclk(lrclk_2518)
);
endmodule