`timescale 1ps/1ps
module DataMemory (
    address,
    writeData,
    readData,
    memWrite,
    memRead,
    clk
    );
    parameter WORD = 16, LENGTH = 1024, ADDRESSL = 10;
    input [ADDRESSL-1:0]address;
    input [WORD-1:0]writeData;
    input memWrite,
    memRead,
    clk;
    output reg [WORD-1:0]readData;
    reg [WORD-1:0]memory[LENGTH-1:0];

    integer i;

    initial begin
        readData <= 0;
        for (i = 0; i < LENGTH; i = i + 1) begin
            memory[i] = 0;
        end
    end

    always(@posedge clk) begin 
        if (memRead == 1'b1)
            readData <= memory[address]
        if (memWrite == 1'b1)
            memory[address] <= writeData
    end
                      
endmodule
