`timescale 1ps/1ps 
 module regFile ( 
   readReg1, 
   readReg2,
   writeReg,
   window,

	writeData,

	writeEn,
	rst,
	clk,

	readData1,
	readData2,
	);
	input [1:0] readReg1, readReg2, writeReg, window;
	input [15:0] writeData;
	input writeEn, rst, clk;

	output [15:0]readData1, readData2;
	parameter W0 = 2'b00, W1 = 2'b01, W2 = 2'b10, W3 = 2'b11;
	reg [2:0] reg1 = 3'b000;
	reg [2:0] reg2 = 3'b000;
	reg [2:0] regW = 3'b000;

	reg [15:0] registers[7:0]; 
	always @(window, readReg1, readReg2, writeReg) begin

		reg1 = (window == W0) ? {1'b0, readReg1} :
						(window == W1) ? {1'b0, readReg1} + 3'b010 :
						(window == W2) ? {1'b0, readReg1} + 3'b100 :
						(window == W3) ? {1'b0, readReg1} + 3'b110 :
						{1'b0, readReg1};
						
		reg2 = (window == W0) ? {1'b0, readReg2} :
						(window == W1) ? {1'b0, readReg2} + 3'b010 :
						(window == W2) ? {1'b0, readReg2} + 3'b100 :
						(window == W3) ? {1'b0, readReg2} + 3'b110 :
						{1'b0, readReg2};
		
		regW = (window == W0) ? {1'b0, writeReg} :
						(window == W1) ? {1'b0, writeReg} + 3'b010 :
						(window == W2) ? {1'b0, writeReg} + 3'b100 :
						(window == W3) ? {1'b0, writeReg} + 3'b110 :
						{1'b0, writeReg};
	end
					
	always @(posedge rst,posedge clk) begin
		if(rst) {registers[0],registers[1],registers[2],registers[3],registers[4],registers[5],registers[6],registers[7]} = 128'b0;
		else begin
			if(writeEn) registers[regW]= writeData;
		end
	end

	assign readData1= registers[reg1];
	assign readData2= registers[reg2];

	endmodule