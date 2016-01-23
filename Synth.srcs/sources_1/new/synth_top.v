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
     
     output wire sd_2518,   // Shut down - active low
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

ODDR #(
      .DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE"
      .INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC"
   ) ODDR_inst (
      .Q(mclk_2518), // 1-bit DDR output
      .C(mclk),      // 1-bit clock input
      .CE(1'b1),  // 1-bit clock enable input
      .D1(1'b1),  // 1-bit data input (positive edge)
      .D2(1'b0),  // 1-bit data input (negative edge)
      .R(1'b0),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );
   
   // Power down the device on startup.
   reg [11:0] power_down_counter = 12'b0;
   assign sd_2518 = power_down_counter[11];
   always@( posedge(mclk) ) begin
       if (power_down_counter[11] == 0) begin
           power_down_counter = power_down_counter + 1;
       end       
   end

wire signed [`CHANNELDEPTH -1:0] sawtooth;

oscillator Osc1[15:0](
    .enable(sw),
    .lrclk(lrclk_2518),
    .sawtooth(sawtooth)
);

i2s_tx i2stx(
    .bclk(bclk_2518),
    .lrclk(lrclk_2518),
    .mclk(mclk),
    .sdata(sdata_2518),
    .left_chan(sawtooth),
    .right_chan(sawtooth)
);
clk_div clkdiv_i(
    .clk(clk),
    .mclk(mclk),
    .bclk(bclk_2518),
    .lrclk(lrclk_2518)
);
endmodule