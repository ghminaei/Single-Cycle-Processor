`timescale 1ps/1ps
module mips (
    clk,
    rst
    );

    input clk,
          rst;

    wire rstPC,
    pcSel,
    branchSel,
    jumpSel,
    regSel,
    inSel,
    selDm,
    selALU,
    regWrite,
    nop,
    ldWnd,
    memWrite,
    memRead,
    selControl,
    selFunc,
    selRj,
    regJsel;

    wire [1:0] wndCtrl;
    wire [2:0] funcCtrl;
    wire [3:0] instOut;
    wire [7:0] funcOut,
               funcIn,
               aluCuF;

    DP dp(
        .clk(clk),
        .rst(rst),
        .rstPC(rstPC),
        .pcSel(pcSel),
        .branchSel(branchSel),
        .jumpSel(jumpSel),
        .regSel(regSel),
        .inSel(inSel),
        .selDm(selDm),
        .selALU(selALU),
        .regWrite(regWrite),
        .nop(nop),
        .ldWnd(ldWnd),
        .memWrite(memWrite),
        .memRead(memRead),
        .wndCtrl(wndCtrl),
        .funcCtrl(funcCtrl),
        .instOut(instOut),
        .funcOut(funcOut),
        .selRj(selRj),
        .regJsel(regJsel)
    );

    CU cu(
        .rst(rst),
        .opcode(instOut),
        .funcCtrl(aluCuF),
        .memRead(memRead),
        .selDM(selDm),
        .regWrite(regWrite),
        .branchSel(branchSel),
        .jumpSel(jumpSel),
        .pcSel(pcSel),
        .selCtrl(selControl),
        .memWrite(memWrite),
        .selFunc(selFunc),
        .regSel(regSel),
        .imSel(inSel),
        .selALU(selALU),
        .selRj(selRj),
        .regJsel(regJsel)
    );

    aluCU alucu(
        .rst(rst),
        .func(funcIn),
        .nop(nop),
        .window(wndCtrl),
        .aluFunc(funcCtrl),
        .ldWnd(ldWnd)
    );

    mux2 #(8) mALU(
        .sel1(selControl),
        .sel2(selFunc),
        .inp1(aluCuF),
        .inp2(funcOut),
        .out(funcIn)
    );
    
endmodule
