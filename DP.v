`timescale 1ps/1ps
module DP (
    clk,
    rst,
    rstPC,
    ldPC,
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

    wndCtrl,
    funcCtrl,

    instOut,
    funcOut
    );

    input [1:0] wndCtrl;
    input [2:0] funcCtrl;
    input clk,
    rst,
    rstPC,
    ldPC,
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
    memRead;

    output [3:0] instOut;
    output [7:0] funcOut;

    
    wire [15:0] ins;
    wire [15:0] regReadData1, 
                regReadData2, 
                ALUOP1, 
                cnctOP, 
                ALURes, 
                DMReadData,
                writeData;
    wire [9:0] addressIM, 
               adderRes, 
               cnctPC, 
               PC;
    wire [1:0] wndScr;
    wire br, 
         regCtrl, 
         zero;

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
        .out(cnctPC)
    );

    Concatenator #(8, 8) cnct2(
        .inp(ins[7:0]),
        .concatPart(8'b0),
        .out(cnctOP)
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
        .inp1(cnctPC),
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

    mux2 #(16) mx3(
        .sel1(selDm),
        .sel2(selALU),
        .inp1(DMReadData),
        .inp2(ALURes),
        .out(writeData)
    ); //MUST CHECK
    
    regFile rf( 
        .readReg1(ins[11:10]), 
        .readReg2(ins[9:8]),
        .writeReg(ins[11:10]),
        .window(wndSrc),
	    .writeData(writeData),
	    .writeEn(regCtrl),
	    .rst(rst),
	    .clk(clk),
	    .readData1(regReadData1),
	    .readData2(regReadData2)
	);


    assign br = branchSel & zero;
    assign regCtrl = regWrite & nop;
endmodule
