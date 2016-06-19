`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:43:43 03/12/2016 
// Design Name: 
// Module Name:    inst_rom 
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
module inst_rom(
	input wire clk,
	input wire [31:0] addr,
	output wire [31:0] dout
    );

	parameter ADDR_WIDTH = 6;
	
	reg [31:0] data [0:(1<<ADDR_WIDTH)-1];
	
	initial begin
		$readmemh("inst_mem.hex", data);
	end

	assign dout = (addr[31:ADDR_WIDTH] != 0) ? 32'b0 : data[addr[ADDR_WIDTH-1:0]];
endmodule
