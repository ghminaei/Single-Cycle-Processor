`timescale 1ps/1ps
module aluCU (
    rst,
    func,
    nop,
    window,
    aluFunc,
    ldWnd
    );
    input rst;
    input [7:0]func;
    output reg [3:0]aluFunc;
    output [1:0]window;
    output reg ldWnd, nop;
    
    parameter  MOVEF = 8'b00000001, ADDF = 8'b00000010,
               SUBF  = 8'b00000100, ANDF = 8'b00001000,
               ORF   = 8'b00010000, NOTF = 8'b00100000, 
               NOPF  = 8'b01000000, WND0 = 8'b10000000,
               WND1  = 8'b10000001, WND2 = 8'b10000010,
               WND3  = 8'b10000011;
    parameter  MOVE  = 3'b000, ADD = 3'b001,
               SUB   = 3'B010, AND = 3'b011,
               OR    = 3'B100, NOT = 3'b101, 
               NOP   = 3'b110;

    assign window = func[1:0];

    always @(*) begin
        if (rst) begin
           aluFunc = NOP;
           ldWnd = 1'b0;
        end
        else begin
            aluFunc = NOP;
            ldWnd = 1'b0;
            case(func)
            MOVEF : begin aluFunc = MOVE;
                          nop = 1;
                    end
            ADDF : begin aluFunc = ADD;
                          nop = 1;
                    end
            SUBF : begin aluFunc = SUB;
                          nop = 1;
                    end
            ANDF : begin aluFunc = AND;
                          nop = 1;
                    end
            ORF : begin aluFunc = OR;
                          nop = 1;
                    end
            NOTF : begin aluFunc = NOT;
                          nop = 1;
                    end
            NOPF : begin aluFunc = NOP;
                          nop = 1;
                    end
            WND0 : ldWnd = 1;
            WND1 : ldWnd = 1;
            WND2 : ldWnd = 1;
            WND3 : ldWnd = 1;
            endcase
        end
    end
endmodule




