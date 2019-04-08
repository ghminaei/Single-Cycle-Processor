`timescale 1ps/1ps
module CU (
    rst,
    opcode,

    funcCtrl,

    memRead,
    selDM,
    regWrite,
    branchSel,
    jumpSel,
    pcSel,
    selCtrl,
    memWrite,
    selFunc,
    ldPC,
    regSel,
    imSel,
    selALU
    );
    input rst;
    input [3:0]opcode;
    output reg [7:0]funcCtrl;
    output reg memRead,
    selDM,
    regWrite,
    branchSel,
    jumpSel,
    pcSel,
    selCtrl,
    memWrite,
    selFunc,
    ldPC,
    regSel,
    imSel,
    selALU;

    parameter LOAD = 4'b0000, STORE = 4'b0001, JUMP = 4'b0010, 
              BRANCHZ = 4'b0100, TYPEC = 4'b1000, 
              ADDI = 4'b1100, SUBI = 4'b1101, ANDI = 4'b1110, ORI = 4'b1111;
    
    parameter  ADD = 8'b00000010, SUB = 8'b00000100,
               AND = 8'b00001000, OR  = 8'b00010000,
               NOP = 8'b01000000;

    always @(*) begin
        if (rst) begin
            memRead = 0;
            selDM = 0;
            regWrite = 0;
            branchSel = 0;
            jumpSel = 0;
            pcSel = 0;
            selCtrl = 0;
            memWrite = 0;
            selFunc = 0;
            ldPC = 0;
            regSel = 0;
            imSel = 0;
            selALU = 0;
        end
        else begin
            funcCtrl = NOP;
            memRead = 0;
            selDM = 0;
            regWrite = 0;
            branchSel = 0;
            jumpSel = 0;
            pcSel = 0;
            selCtrl = 0;
            memWrite = 0;
            selFunc = 0;
            ldPC = 0;
            regSel = 0;
            imSel = 0;
            selALU = 0;
            case(opcode)
            LOAD: begin memRead = 1; 
                        selDM = 1; 
                        regWrite = 1; 
                        pcSel = 1;
                        ldPC = 1; 
                  end
            STORE: begin pcSel = 1;
                         memWrite = 1; 
                         ldPC = 1; 
                  end
            JUMP: begin jumpSel = 1;
                        ldPC = 1;
                  end
            BRANCHZ: begin branchSel = 1;
                           selCtrl = 1;
                           ldPC = 1;
                           funcCtrl = SUB;
                     end
            TYPEC: begin regWrite <= 1;
                         pcSel <= 1;
                         ldPC = 1;
                         selFunc <= 1;
                         regSel <= 1;
                         selALU = 1;
                   end
            ADDI: begin regWrite = 1;
                        pcSel = 1;
                        selCtrl = 1;
                        ldPC = 1;
                        imSel = 1;
                        funcCtrl = ADD;
                        selALU = 1;
                  end
            SUBI: begin regWrite = 1;
                        pcSel = 1;
                        selCtrl = 1;
                        ldPC = 1;
                        imSel = 1;
                        funcCtrl = SUB;
                        selALU = 1;
                  end
            ANDI: begin regWrite = 1;
                        pcSel = 1;
                        selCtrl = 1;
                        ldPC = 1;
                        imSel = 1;
                        funcCtrl = AND;
                        selALU = 1;
                  end
            ORI: begin regWrite = 1;
                        pcSel = 1;
                        selCtrl = 1;
                        ldPC = 1;
                        imSel = 1;
                        funcCtrl = OR;
                        selALU = 1;
                  end

            endcase
        end
    end
endmodule




