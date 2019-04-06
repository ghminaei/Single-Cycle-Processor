`timescale 1ps/1ps
module subSum (
    inp1,
    inp2,
    mode,
    out
    );
    parameter n = 14;
    input signed[n-1:0]inp1,
    inp2;
    input mode;
    output signed[n-1:0]out;

    assign out = mode ? inp2-inp1 : inp1+inp2;
endmodule
                  
