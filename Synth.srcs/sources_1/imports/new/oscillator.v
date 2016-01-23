`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: JUIXXXE
//////////////////////////////////////////////////////////////////////////////////
`define CHANNELDEPTH 16

`define BASERATE (48000.0/16777216.0)
`define A3  76896 // 220.00/`BASERATE
`define B3 	86312 // 246.94/`BASERATE
`define C4  91446 // 261.63/`BASERATE
`define D4  102642 // 293.66/`BASERATE
`define E4  115214 // 329.63/`BASERATE
`define F4  122065 // 349.23/`BASERATE
`define G4  137014 // 392.00/`BASERATE
`define A4  153791 // 440.00/`BASERATE
`define B4  172624 // 493.88/`BASERATE
`define C5  182889 // 523.25/`BASERATE
`define D5  205287 // 587.33/`BASERATE
`define E5  230425 // 659.25/`BASERATE
`define F5  244129 // 698.46/`BASERATE
`define G5  274024 // 783.99/`BASERATE
`define A5  307582 // 880.00/`BASERATE
`define B5  345251 // 987.77/`BASERATE

module oscillator(
    input [15:0] enable,
    input lrclk,
    output reg signed [`CHANNELDEPTH-1:0] sawtooth = 0
    );
    
    reg signed [23:0] sawtooth_internal [15:0];
    reg [23:0] rate [15:0];     
      
reg initialstate = 1;

reg [4:0] i =0;
always@(posedge(lrclk)) begin
    if(initialstate)begin
    
        rate[0] = `A3;
        rate[1] = `B3;
        rate[2] = `C4;
        rate[3] = `D4;
        rate[4] = `E4;
        rate[5] = `F4;
        rate[6] = `G4;
        rate[7] = `A4;
        rate[8] = `B4;
        rate[9] = `C5;
        rate[10] = `D5;
        rate[11] = `E5;
        rate[12] = `F5;
        rate[13] = `G5;
        rate[14] = `A5;
        rate[15] = `B5;

        for(i = 0; i<16; i=i+1) begin
            sawtooth_internal[i] = 0;
        end

        initialstate = 0;
    end
    else begin
        sawtooth = 0;
        for(i = 0; i<16; i=i+1) begin
            sawtooth_internal[i] = enable[i] ? sawtooth_internal[i] + rate[i] : 0;
            sawtooth = sawtooth + (sawtooth_internal[i][23:8]>>6);
            if(enable[i])begin
                $display(sawtooth_internal[i]);
                $display(sawtooth); 
            end
        end
    end
end

endmodule