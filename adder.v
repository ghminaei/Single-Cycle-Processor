`timescale 1ps/1ps
module adder (
    inp1,
    inp2,
    out
    );
    parameter n = 10;
    input [n-1:0]inp1,
    inp2;
    output [n-1:0]out;

    assign out = inp1+inp2;
    
endmodule
                  
