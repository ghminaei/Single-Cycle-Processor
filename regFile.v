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

	reg [2:0] reg1 = 3'b000;
	reg [2:0] reg2 = 3'b000;
	reg [2:0] regW = 3'b000;

	reg [15:0] registers[7:0]; 

	always @(posedge rst,posedge clk ,window) begin
		if(rst) {registers[0],registers[1],registers[2],registers[3],registers[4],registers[5],registers[6],registers[7]} = 128'b0;
		else begin
			case(window)
			2'b00: begin 
				reg1 = {1'b0,readReg1};
				reg2 = {1'b0,readReg2};
				regW = {1'b0,readReg2};
			   end
			2'b01: begin 
				reg1 = {1'b0,readReg1} + 3'b010;
				reg2 = {1'b0,readReg2} + 3'b010;
				regW = {1'b0,writeReg} + 3'b010;
			   end
			2'b10: begin 
				reg1 = {1'b0,readReg1} + 3'b100;
				reg2 = {1'b0,readReg2} + 3'b100;
				regW = {1'b0,writeReg} + 3'b010;
			   end
			2'b11: begin 
				reg1 = {1'b0,readReg1} + 3'b110;
				reg2 = {1'b0,readReg2} + 3'b110;
				regW = {1'b0,writeReg} + 3'b010;
			   end
			endcase
			if(writeEn) registers[regW]= writeData;
		end
	end

	assign readData1= registers[reg1];
	assign readData2= registers[reg2];

	endmodule