`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: johnjose
// 
// Create Date: 09/08/2021 01:46:15 PM
// Design Name: datamemory
// Module Name: datamemory
// Project Name: microprocessor
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


module datamemory(
    input clk, // clock signal
    input write, // read/write when not writing it reads
    input [7:0] address, // 256 byte  adddress location
    input [7:0] datain, //8bit data 
    output[7:0] dataout //8 bit dataout
      );
     reg [0:7]ram[0:255] ; // 256 byte  memory
     reg [7:0] addressregister; //address register for storing
     integer i;
     initial begin
        for (i=0; i<256; i=i+1)
            ram[i] = 8'h0;
     end
     always @(negedge clk) // telling clock to work in positive edge
     begin
        if (write)  //if write == 1 then write
        ram[address]<=datain;  // get data from data in into the address register
        else // if write == 0 then read
        addressregister <= address; // assign value to an addreess register not doing that is giving an error
     end 
     assign dataout = ram[addressregister];    //data value is finally assigned
endmodule
