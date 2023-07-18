`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:50:34 11/11/2021 
// Design Name: 
// Module Name:    color_converter 
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
module color_converter(
    input [7:0] color_code,
    output reg [7:0] color_out
    );
	
	always @(color_code)
	begin
		case(color_code)
			8'd00: color_out <= 8'b00000000; // Black
			8'd01: color_out <= 8'b11100000; // Red
			8'd02: color_out <= 8'b00011100; // Green
			8'd03: color_out <= 8'b00000011; // Blue
			8'd04: color_out <= 8'b11111100; // Yellow
			8'd05: color_out <= 8'b11100011; // Magenta
			8'd06: color_out <= 8'b00011111; // Cyan
			8'd07: color_out <= 8'b10010010; // Grey
			8'd08: color_out <= 8'b00100101; // Grey Blue
			8'd09: color_out <= 8'b01111010; // Seafoam
			8'd10: color_out <= 8'b01101010; // Purple
			8'd11: color_out <= 8'b11101010; // Pink
			8'd12: color_out <= 8'b11110110; // Peach
			8'd13: color_out <= 8'b10110111; // Light Blue
			8'd14: color_out <= 8'b11010101; // Dark purple
			8'd15: color_out <= 8'b11111111; // White
			default: color_out <= 8'b00000000; // Black
		endcase
	end

endmodule
