`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2021 10:50:43 AM
// Design Name: 
// Module Name: alu
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


module alu(
           input [7:0] A,B,  // ALU 8-bit Inputs                 
           input [3:0] FS,// ALU 4 Selection
           input [2:0] sh, //shift  project
           output [7:0] F, // ALU 8-bit Output
           output C, // Carry Out Flag
           output N ,//negative flag
           output V ,// overflow flag
           output Z // zero flag
           
    );
reg [8:0] outputreg ;// output register to store values
reg zeroflag;
reg overflowflag;
reg carryflag;
reg negativeflag;
reg [7:0]overflowregister;
reg [2:0] shift;
parameter d = 0;
parameter nop = 4'b0000; // value 0
parameter add = 4'b0001; //value 1
parameter sub = 4'b0010; //value 2
parameter xor2 =	4'b0011; // value 3
parameter or2  =	4'b0100; //value 4
parameter logicshift_right	= 4'b0101; //value 5
parameter logicshift_left = 4'b0110; //value 6
parameter compliment =	4'b0111; //value 7
parameter bypass  =	4'b1000; //value 8
parameter and2	= 4'b1001; //value 9
parameter greater_comparison = 	4'b1010; //value 10
parameter equality_comparison = 4'b1011; // value 11
parameter not2 = 4'b1100; // value 12

always @(A,B,FS,sh)
begin
//shift = sh;
case(FS)
    add:
    outputreg = A + B; //add a and b
    sub:
    outputreg = A + ~B + 1; // sub a - b
    and2:
    //$display("%d",d);
    outputreg = A & B; // a and b
    or2:
    outputreg = A | B; // a or b
    xor2:
    outputreg = A ^ B; // xor a and b
    bypass:
    outputreg = A; // by pass a to output
    not2:
    outputreg = ~A; // negate a and give to output
    greater_comparison:
    outputreg = A>B ? 1'b0 : 1'b1 ; //output a if a larger b if  b is larger.
    equality_comparison:
    outputreg = A==B ? 8'h0 : 8'h1; // outputs zero or 1  
    logicshift_right:
    outputreg = A >> sh; //  right shift
    logicshift_left:
    outputreg = A << sh; // left shift
    compliment:
    outputreg = ~A;
    default:
    outputreg = 9'h0;
endcase

//assign F = outputreg
zeroflag = (outputreg == 0 )? 1'b1: 1'b0;// zero flag is set when the output register value is 0
negativeflag = outputreg[7];// negative flag is set when there is a one in the seventh bit
carryflag = outputreg[8];// carrry flag is set if there is a carry
if (FS == 1 )begin
  overflowflag = ( (A[7] == B[7]) && (A[7] !=  outputreg[7])) ? 1'b1 : 1'b0; // overflow will happen when the carry of first msb and 2nd msb 's carry xor ed
   end
  else if (FS == 2 )begin
   overflowregister = ~B+8'b1;
  overflowflag = ( (A[7] == overflowregister[7]) && (A[7] !=  outputreg[7])) ? 1'b1 : 1'b0; // overflow consdition for the substract flag.
   end
//overflowflag = ( (A[7] == B[7]) && (A[7] !=  outputreg[7])) ? 1'b1 : 1'b0;
end

assign F = outputreg[7:0];
assign N = negativeflag;
assign C = carryflag;
assign V = overflowflag;
assign Z = zeroflag;

endmodule


    
   
