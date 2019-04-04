`timescale 1ps/1ps
module mux2 (
    sel1,
    sel2,
    inp1,
    inp2,
    out
    );
    parameter n;
    input sel1,
    sel2;
    input [n-1:0]inp1, inp2;
    output [n-1:0]out;

    assign out = sel1 ? inp1 : 
                 sel2 ? inp2 : 
                 out;
endmodule




