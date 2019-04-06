`timescale 1ps/1ps
module mux3 (
    sel1,
    sel2,
    sel3,
    inp1,
    inp2,
    inp3,
    out
    );
    parameter n;
    input sel1,
    sel2,
    sel3;
    input [n-1:0]inp1, inp2, inp3;
    output [n-1:0]out;

    assign out = sel1 ? inp1 : 
                 sel2 ? inp2 : 
                 sel3 ? inp3 :
                 out;
endmodule
/*asgharfor tetsinbg */