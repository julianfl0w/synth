`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: JUIXXXE
//////////////////////////////////////////////////////////////////////////////////
`define CHANNELDEPTH 16
module oscillator(
    input mclk,
    input lrclk,
    output reg signed [`CHANNELDEPTH-1:0] sawtooth = 0
    );
    
reg lr_last;
always@(posedge(mclk)) begin
    if (lr_last == 1'b0) begin
        if(lrclk == 1'b1) begin
            sawtooth = sawtooth + (1<<6); 
        end
    end
    lr_last <= lrclk; 
end
endmodule