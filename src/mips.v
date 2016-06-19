`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:31:00 03/12/2016 
// Design Name: 
// Module Name:    mips 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mips(
	`ifdef DEBUG
	input wire debug_en,
	input wire debug_step,
	input wire [6:0] debug_addr,
	output wire [31:0] debug_data,
	output wire [31:0] debug_inst_addr,
	output wire [31:0] debug_inst_data,
	`endif
	input wire clk,
	input wire rst,
	input wire interrupter
    );
	
	wire inst_ren;
	wire [31:0] inst_addr;
	wire [31:0] inst_data;
	
	wire men_ren, men_wen;
	wire [31:0] mem_addr;
	wire [31:0] mem_data_r;
	wire [31:0] mem_data_w;
	
	assign debug_inst_addr = inst_addr;
	assign debug_inst_data = inst_data;
	mips_core MIPS_CORE(
		.clk(clk),
		.rst(rst),
		`ifdef DEBUG
		.debug_en(debug_en),
		.debug_step(debug_step),
		.debug_addr(debug_addr),
		.debug_data(debug_data),
		`endif
		.inst_ren(inst_ren),
		.inst_addr(inst_addr),
		.inst_data(inst_data),
		.mem_ren(mem_ren),
		.mem_wen(mem_wen),
		.mem_addr(mem_addr),
		.mem_dout(mem_data_w),
		.mem_din(mem_data_r)
	);

	inst_rom INST_ROM(
		.clk(clk),
		.addr({2'b0, inst_addr[31:2]}),
		.dout(inst_data)
	);
	
	data_ram DATA_RAM(
		.clk(clk),
		.we(mem_wen),
		.addr({2'b0, mem_addr[31:2]}),
		.din(mem_data_w),
		.dout(mem_data_r)
	);
endmodule
