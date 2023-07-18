`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 09:38:25 AM
// Design Name: 
// Module Name: input_output
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module excess
(
input clk,
input reset,
input output_write_enble,
input [7:0] output_data_in,
input [7:0] output_data_address,
input [8:0] fpga_in,
output [7:0] input_data_out,
output [9:0] fpga_out
);

    reg [0:4]input_out_store[0:15] ; // 256 byte  memory
     reg [3:0] addressregister; //address register for storing
     integer i;
     initial begin
        for (i=0; i<16; i=i+1)
            input_out_store[i] = 4'h0;
     end
     always @(posedge clk , reset) // telling clock to work in positive edge
     begin
        if (output_write_enble)  //if write == 1 then write
        input_out_store[addressregister]<=output_data_in;  // get data from data in into the address register
        else // if write == 0 then read
        addressregister <= output_data_address; // assign value to an addreess register not doing that is giving an error
     end 
     assign input_data_out = input_out_store[addressregister]; 




endmodule
