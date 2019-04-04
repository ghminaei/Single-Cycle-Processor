`timescale 1ps/1ps
module ALU (
    inp1,
    inp2,
    func,
    out
    );
    parameter n = 16;
    input [n-1:0]inp1, inp2;
    input [2:0]func;
    output [n-1:0]out;

    wire [2:0] MOV = 3'b000, ADD = 3'b001, SUB = 3'b010, AND = 3'b011,
               OR  = 3'b100, NOT = 3'b101, NOP = 3'b110;

    assign out = (func == MOV) ? inp2 :
                 (func == ADD) ? inp1 + inp2 :
                 (func == SUB) ? inp1 - inp2 :
                 (func == AND) ? inp1 & inp2 :
                 (func == OR ) ? inp1 | inp2 :
                 (func == NOT) ? ~inp2 :
                 (func == NOP) ? out :
                 out;
                 
endmodule