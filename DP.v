`timescale 1ps/1ps
module DP (
    clk,
    rst,
    rstPC,
    ldPC,
    pcSel,
    brachSel,
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

    wndCtrl,
    funcCtrl,
    );

    input [1:0] wndCtrl;
    input [2:0] funcCtrl;
    input clk,
    rst,
    rstPC,
    ldPC,
    pcSel,
    brachSel,
    jumpSel,
    regSel,
    inSel,
    selDm,
    selALU,
    regWrite,
    nop,
    ldWnd,
    memWrite,
    memRead;


    register #(10) pcReg(
        .clk(clk),
        .rst(rstPC), //IS THIS OK?
        .ld(ldPC),
        .clr(),
        .inp(PC),
        .out(addressIM)
    );

    register #(2) wndReg(
        .clk(clk),
        .rst(rst), //IS THIS OK?
        .ld(ldWnd),
        .clr(),
        .inp(wndCtrl),
        .out(wndScr)
    );

    DataMemory dm(
        .address(ins[9:0]),
        .writeData(regReadData1),
        .readData(DMReadData),
        .memWrite(memWrite),
        .memRead(memRead),
        .clk(clk)
    );
    
    InstMemory im(
        .address(addressIM),
        .out(ins)
    );

    Adder adder(
        .inp1(10'b0000000001),
        .inp2(addressIM),
        .out(adderRes)
    );

    Concatenator #(8, 2) cnct1(
        .inp(ins[7:0]),
        .concatPart(addressIM[9:8]),
        .out(cntcPC)
    );

    Concatenator #(8, 8) cnct2(
        .inp(ins[7:0]),
        .concatPart(8'b0),
        .out(cntcOP)
    );

    ALU alu(
        .inp1(ALUOP1),
        .inp2(regReadData2),
        .func(funcCtrl),
        .out(ALURes),
        .zero(zero)
    );

    mux3 #(10) mx1(
        .sel1(jumpSel),
        .sel2(br),
        .sel3(pcSel),
        .inp1(cntcPC),
        .inp2(ins[9:0]),
        .inp3(adderRes),
        .out(PC)
    ); //MUST CHECK

    mux2 #(16) mx2(
        .sel1(inSel),
        .sel2(regSel),
        .inp1(cnctOP),
        .inp2(regReadData1),
        .out(ALUOP1)
    ); //MUST CHECK
    
    //REGISTERFILE


    assign br = branchSel & zero;
    assign regCtrl = regWrite & nop;
endmodule
