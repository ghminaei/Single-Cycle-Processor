`timescale 1ps/1ps
module InstMemory (
    address,
    out
    );
    parameter WORD = 16, LENGTH = 1024, PCL = 10;
    input [PCL-1:0]address;
    output [WORD-1:0]out;
    reg [WORD-1:0]memory[LENGTH-1:0];
    parameter NOP = 16'b1000000001000000;
    integer i;
    initial begin
        for (i = 0; i < LENGTH; i = i + 1) begin
            memory[i] = NOP;
        end
    end

    initial begin 
        $readmemb("instructions.txt", memory);
    end

    assign out = memory[address];
endmodule
