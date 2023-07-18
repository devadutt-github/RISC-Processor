`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2021 10:14:07 AM
// Design Name: 
// Module Name: acessorry_componets
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
// constnst module declaration
module constant(
input [5:0] immidiate_value,  // get the immdeidtae  value
input cs,
output [7:0] constant_unit_out

    );
reg [7:0] constantunit;

always@(cs , immidiate_value)begin
if (cs)
    if (immidiate_value[5] == 1'b0)
        constantunit =  8'b0000_0000+  immidiate_value ;
    else
        constantunit = 8'b1100_0000 + immidiate_value;
else
    constantunit = 8'b0000_0000+  immidiate_value;
end
assign constant_unit_out = constantunit;
endmodule



// mux a implementation
module mux_a(
input MA, // mux a selector lines
input [7:0]PC_minus1,  //pc value from prevous cycle
input [7:0]register_a, //register a value output
output [7:0] mux_a_out  // mux a output value
);
reg [7:0] mux_a;  // register value a out
always@(MA,PC_minus1,register_a)begin

if (MA)
    mux_a = PC_minus1;
else
    mux_a = register_a;
end
assign mux_a_out = mux_a ;
endmodule


module mux_b(
input MB, // mux a selector lines
input [7:0]constantunit_out,  //pc value from prevous cycle
input [7:0]register_b, //register a value output
output [7:0]mux_b_out  // mux a output value
);
reg [7:0]mux_b;  // register value a out
always@(MB,constantunit_out,register_b)begin

if (MB)
    mux_b = constantunit_out;
else
    mux_b = register_b;
end
assign mux_b_out = mux_b ;
endmodule


module mux_d(
input [1:0] MD, // mux a selector lines
input [7:0]alu_out,  //pc value from prevous cycle
input [7:0] mem_data, //register a value output
input [7:0] in_out,
output [7:0] mux_d_out  // mux a output value
);
reg [7:0]mux_d;  // register value a out
always@(MD,alu_out,mem_data,in_out)begin

if (MD == 2'b01)
    begin
    mux_d = mem_data;
    end
else if (MD == 2'b10)
    begin
    mux_d = in_out;
    end
else
    begin
    mux_d = alu_out;
    end
end
assign mux_d_out = mux_d ;
endmodule



module mux_c(
input [1:0] BS, // mux a selector lines
input [7:0] pc_value,  //pc value from prevous cycle
input [7:0] RAA, //register a value output
input [7:0] Braa,
output [7:0] pc_out

);
parameter pc = 2'b00;
parameter jump = 2'b10;
reg [7:0]mux_c;  // mux c  out
always@( BS , pc_value, RAA, Braa)begin

case (BS)  
    pc:
    mux_c = pc_value + 8'h1;
    
    jump:
    mux_c = RAA;
    default:
    mux_c = Braa; 
endcase
end
assign pc_out = mux_c ;
endmodule

module adder(
input [7:0]pc,
input [7:0]bus_b,
output [7:0]BrA);
assign BrA = pc + bus_b;

endmodule

module brancher(
input [1:0] BS_in,
input ps,
input z,
output [1:0] BS_out);
assign BS_out = {BS_in[1],(BS_in[0]&(BS_in[1]|(ps ^ z)))};
endmodule

