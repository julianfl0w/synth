`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: JUIXXXE
//////////////////////////////////////////////////////////////////////////////////


module synth_top_tb(
    );
    
reg clk;
initial clk = 0;
always #1 clk = ~clk;

synth_top synth_top_i(
    .clk(clk),
    .sw(16'h0040),
    .btnC(1'b0),
    .btnU(1'b0),
    .btnD(1'b0),
    .btnR(1'b0),
    .btnL(1'b0),
    
    .lrclk_2518(lrclk_2518),
    .sdata_2518(sdata_2518),
    .bclk_2518(bclk_2518),
    .mclk_2518(mclk_2518),
    .sd_2518(sd_2518)
     );

endmodule
