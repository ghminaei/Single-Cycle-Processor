`timescale 1ps/1ps
module Concatenator (
    inp,
    out
    );
    parameter NINP = 8;
    parameter NZERO;
    input [NINP-1:0]inp;
    output [NZERO+NINP-1:0]out;
//WROOOOOOOOOONG
    assign out = (NZERO){1'b0}, inp
endmodule




