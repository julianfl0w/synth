`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: JUIXXXE
//////////////////////////////////////////////////////////////////////////////////
module clk_div(
    input clk,
    output wire mclk,
    output wire bclk,
    output wire lrclk
    );
wire clkfb;
reg [13:0] mclk_count = 14'b0;
MMCME2_BASE #(
      .BANDWIDTH("OPTIMIZED"),   // Jitter programming (OPTIMIZED, HIGH, LOW)
      .CLKFBOUT_MULT_F(7.0),     // Multiply value for all CLKOUT (2.000-64.000).
      .CLKFBOUT_PHASE(0.0),      // Phase offset in degrees of CLKFB (-360.000-360.000).
      .CLKIN1_PERIOD(10.0),       // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      // CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
      .CLKOUT0_DIVIDE_F(57.0),    // Divide amount for CLKOUT0 (1.000-128.000).
      .CLKOUT1_DIVIDE(14),
      .CLKOUT2_DIVIDE(14),
      .CLKOUT3_DIVIDE(14),
      .CLKOUT4_DIVIDE(14),
      .CLKOUT5_DIVIDE(14),
      .CLKOUT6_DIVIDE(14),
      // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.01-0.99).
      .CLKOUT0_DUTY_CYCLE(0.5),
      .CLKOUT1_DUTY_CYCLE(0.5),
      .CLKOUT2_DUTY_CYCLE(0.5),
      .CLKOUT3_DUTY_CYCLE(0.5),
      .CLKOUT4_DUTY_CYCLE(0.5),
      .CLKOUT5_DUTY_CYCLE(0.5),
      .CLKOUT6_DUTY_CYCLE(0.5),
      // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      .CLKOUT0_PHASE(0.0),
      .CLKOUT1_PHASE(0.0),
      .CLKOUT2_PHASE(0.0),
      .CLKOUT3_PHASE(0.0),
      .CLKOUT4_PHASE(0.0),
      .CLKOUT5_PHASE(0.0),
      .CLKOUT6_PHASE(0.0),
      .CLKOUT4_CASCADE("FALSE"), // Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
      .DIVCLK_DIVIDE(1),         // Master division value (1-106)
      .REF_JITTER1(0.0),         // Reference input jitter in UI (0.000-0.999).
      .STARTUP_WAIT("FALSE")     // Delays DONE until MMCM is locked (FALSE, TRUE)
   )
MMCME2_BASE_inst (
      .CLKIN1(clk),       // 1-bit input: Clock
      .CLKOUT0(mclk),     // 1-bit output: CLKOUT0
      .CLKFBOUT(clkfb),   // 1-bit output: Feedback clock
      .CLKFBIN(clkfb),      // 1-bit input: Feedback clock
      .PWRDWN(1'b0),       // 1-bit input: Power-down
      .RST(1'b0)             // 1-bit input: Reset
   );
                    
   assign bclk  = mclk_count[2];  // mclk / 8
   assign lrclk = mclk_count[7]; // mclk / 256
                    
always@(posedge(mclk)) begin
    mclk_count = mclk_count + 1;
end
endmodule
