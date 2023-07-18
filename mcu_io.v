`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:12:51 11/12/2021 
// Design Name: 
// Module Name:    mcu_io 
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
module mcu_io(
	 input clk,  // Clock
	 input reset,// Reset signal
	 input output_write_enable, // Write enable
	 input [7:0] output_data_in, // Data in
	 input [7:0] output_data_address, // Data address
	 output reg [7:0] input_data_out, // Data output
	 input [8:0] fpga_in, // Connection to FPGA input pins
	 output [9:0] fpga_out // Connection to FPGA output pins
    );
	 // Output
	vga_out VGA_OUT(.clk(clk),
			  .write_enable(output_write_enable),
			  .position(output_data_address),
			  .value(output_data_in),
			  .vgaRed(fpga_out[9:7]),
			  .vgaGreen(fpga_out[6:4]),
			  .vgaBlue(fpga_out[3:2]),
			  .Hsync(fpga_out[1]),
			  .Vsync(fpga_out[0])
    );
	 
//	 wire [7:0] sw;
//	 assign sw = fpga_in[7:0];
//	 
//	 always @(negedge clk)
//		if (!reset)
//			input_data_out <= 0;
//		else
//			input_data_out <= sw;
	 
	 // input
	 always @(fpga_in[8])
	 begin
		if (!reset)
			input_data_out <= 8'd0;
		else
			//if (!fpga_in[8])
				input_data_out <= fpga_in[7:0];
	 end

endmodule
