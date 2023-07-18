`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:19:09 09/08/2021 
// Design Name: 
// Module Name:    VGA_driver 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: A VGA module that connects to an 8-bit VGA output. The x_pos and
//					 y_pos outputs represent the next pixel when within the display
//					 frame. When outside the frame, the values will be larger than 
//					 the possible displayable options
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module VGA_driver(
    input clk_25M,
    input [2:0] redIn,
    input [2:0] greenIn,
    input [1:0] blueIn,
    output reg [2:0] vgaRed = 0,
    output reg [2:0] vgaGreen = 0,
    output reg [2:1] vgaBlue = 0,
    output reg Hsync = 0,
    output reg Vsync = 0,
    output reg [9:0] x_pos = 0,
    output reg [9:0] y_pos = 0
    );

	reg [9:0] h_count = 0;
	reg [9:0] v_count = 0;
	
	always @(posedge clk_25M)
	begin
		// Control counter for h_sync and v_sync control
		if (h_count == 799)
		begin
			h_count <= 0;
			if (v_count == 524)
				v_count <= 0;
			else
				v_count <= v_count + 1'b1;
		end
		else
			h_count <= h_count + 1'b1;
		
		// control Hsync signal
		if ((h_count >= 0) && (h_count <= 95))
			Hsync <= 1;
		else
			Hsync <= 0;
		
		// control Vsync signal
		if ((v_count >= 0) && (v_count <= 1))
			Vsync <= 1;
		else
			Vsync <= 0;
			
		// Set color to black when outside of video bounds and output position
		if ((h_count >= 144) && (h_count <= 783) && (v_count >= 35) && (v_count <= 514))
		begin
			vgaRed <= redIn;
			vgaGreen <= greenIn;
			vgaBlue <= blueIn;
		end
		else
		begin
			vgaRed <= 0;
			vgaGreen <= 0;
			vgaBlue <= 0;
		end
		x_pos <= (h_count + 1'b1) - 9'd144; // X position being output is the next position. Will be between 0 and 639 for valid inputs
		y_pos <= v_count - 9'd35; // Y position is current position. Between 0 and 479 for valid inputs
	end


endmodule
