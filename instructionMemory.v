`timescale 1ps/1ps
module InstMemory (
    address,
    out
    );
    parameter WORD = 16, LENGTH = 1024, PCL = 10;
    input [PCL-1:0]address;
    output [WORD-1:0]out;
    reg [WORD-1:0]memory[LENGTH-1:0];
    assign out = memory[address];
endmodule
