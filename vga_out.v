`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:22:58 11/11/2021 
// Design Name: 
// Module Name:    vga_out 
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
module vga_out(
    input clk,
	 input write_enable,
    input [7:0] position,
    input [7:0] value,
    output [2:0] vgaRed,
    output [2:0] vgaGreen,
    output [2:1] vgaBlue,
    output Hsync,
    output Vsync
    );
	 
	 wire clk_vga; // 25MHz clock for vga control
	 
	 // Pixel and color control
	 wire [9:0] x_pos;
	 wire [9:0] y_pos;
	 wire [2:0] redIn;
	 wire [2:0] greenIn;
	 wire [2:1] blueIn;
	 
	 wire [1:0] grid_x;
	 wire [1:0] grid_y;
	 
	 // Memory to store color of each segment
	 reg [7:0] color_mem [0:15];
	 
	 // Wire to carry converted color
	 wire [7:0] converted_color;
	 
	 // Set output color
	 assign {redIn, greenIn, blueIn[2:1]} = color_mem[{grid_y, grid_x}];
	 
	 clock_100to25 CLK_DIV(.clk_100M(clk), .clk_25M(clk_vga));
	 VGA_driver VGA_MOD(.clk_25M(clk_vga),
							 .redIn(redIn),
							 .greenIn(greenIn),
							 .blueIn(blueIn[2:1]),
							 .vgaRed(vgaRed),
							 .vgaGreen(vgaGreen),
							 .vgaBlue(vgaBlue),
							 .Hsync(Hsync),
							 .Vsync(Vsync),
							 .x_pos(x_pos),
							 .y_pos(y_pos)
							 );
	vga_grid16 VGA_GRID(.x_pos(x_pos),.y_pos(y_pos),.grid_x(grid_x),.grid_y(grid_y));
	color_converter COLOR_CONV(.color_code(value),.color_out(converted_color));
	
	always @(negedge clk)
	begin
		if (write_enable)
			color_mem[position] <= converted_color;
	end

endmodule
