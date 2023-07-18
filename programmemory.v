`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: john jose
// 
// Create Date: 09/08/2021 06:29:40 PM
// Design Name: 
// Module Name: program memory
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


module pro_memory(address,reset ,prodata);
    input [7:0]address;
    input reset; // read when low
    output  reg [16:0]prodata; //17 bit instructions




reg [0:16] mem [0:255];

parameter NOP = 5'b00000; // value 0  eg:nop           
parameter SUB = 5'b00001; //value 1   eg: sub r1,r2,r3 
parameter JML = 5'b00010; //value 2   eg: jml r2, r3   
parameter JMP =	5'b00011; // value 3  eg: jmp [r2]     
parameter AIU =	5'b00100; //value 4   eg: aiu r3,r2,06H
parameter ST  = 5'b00101; //value 5   eg: st [r2] r1   
parameter AND = 5'b00110; //value 6   eg: and r3,r2,r1 
parameter JMR =	5'b00111; //value 7   eg: jmp r2       
parameter LSL =	5'b01000; //value 8   eg: lsl r3 , 03H 
parameter ADI = 5'b01001; //value 9   eg: add r3 r2 03H
parameter XOR = 5'b01010; //value 10  eg: xor r4 r3 r2 
parameter BZ  = 5'b01011; // value 11  eg: bz r2 20H   
parameter MOV = 5'b01100; // value 12  eg: mov r2 r1   
parameter LD  = 5'b01101; // value 13  eg: ld r4 [r1]  
parameter SLT = 5'b01110; // value 14  eg: slt r3 r2 r1
parameter ADD = 5'b01111; // value 15  eg: add r3 r2 r1
parameter OUT = 5'b10000; // value 16  eg:  out r3 [r2]
parameter NOT = 5'b10001; // value 17  eg: not r2 R1     
parameter IN  = 5'b10010; // value 18  eg: in r7 [r4]  
parameter BNZ = 5'b10011; // value 19 eg: bnz r2       
parameter ORI = 5'b10100; // value 20  eg: or r3 r2 35H 
parameter LSR = 5'b10101; //value 21 eg eg: lsR r3 , 03H 

   
//   always@(address , reset )
//    begin 
//        case(address)
//                8'h0:mem[address] = 17'h00000_000_000_000_000;
//                8'h1:mem[address] = { AIU , 3'b001 , 3'b000 , 3'b000, 3'b101 }; //AIU R1 R0 5
//                8'h2:mem[address] = { AIU , 3'b010 , 3'b000 , 3'b000, 3'b100 }; //AIU R2 R0 4
//                8'h3:mem[address] = { XOR , 3'b011 , 3'b001 , 3'b010, 3'b000 }; //XOR R3 R1 R2
//                8'h4:mem[address] = { AND , 3'b100 , 3'b001 , 3'b011, 3'b000 };//AND R4 R1 R3
//                8'h5:mem[address] = { LSL , 3'b101 , 3'b100 , 3'b000, 3'b011 };//LSL R5 R4 011 
//                8'h6:mem[address] = { SLT , 3'b101 , 3'b001 , 3'b011, 3'b000 };//SLT R5 R1 R3
//                8'h7:mem[address]  = { SUB , 3'b010 , 3'b101 , 3'b011, 3'b000 };// SUB R2 R5 R3
//                8'h8:mem[address] = { MOV , 3'b111 , 3'b011 , 3'b000, 3'b000 };//MOV R7 R3
//                8'h9:mem[address] = { NOT , 3'b110 , 3'b111 , 3'b000, 3'b000 };// NOT R6 R7
//                8'h10:mem[address] = { ST  , 3'b000 , 3'b010 , 3'b110, 3'b000 };// ST R6 [R2]
//                8'h11:mem[address] = { LD  , 3'b001 , 3'b010 , 3'b000, 3'b000 };// LD R1 [R2]
//                8'h12:mem[address] = 17'h00000_000_000_000_000;
//                default:mem[8'h0] = 17'h00000_000_000_000_000;
//                endcase
////   end



always@(*) begin
case(address) 
//8'd0: prodata  =   { NOP , 3'b000 , 3'b000 , 3'b000, 3'b000 }; //nop
8'd0: prodata  =   { IN , 3'b001 , 3'b000 , 3'b000, 3'b000 }; //IN R1 
8'd1: prodata =    { LSL , 3'b010 , 3'b001 , 3'b000, 3'b100 }; //LSL R2 R1 4
8'd2: prodata =    { LSR , 3'b010 , 3'b010 , 3'b000, 3'b100 }; //LSL R2 R2 4
8'd3: prodata =   { LSR , 3'b011 , 3'b001 , 3'b000, 3'b100 }; //LSL R2 R2 4
8'd4: prodata =   { OUT , 3'b000 , 3'b010 , 3'b011, 3'b000 };//out R2 R3 011                                                      
8'd5: prodata =   { JMR , 3'b000 , 3'b000 , 3'b000, 3'b000 };//SLT R5 R1 R3

endcase
end
endmodule

//always@(*) begin
//end

//initial begin
//mem[address] = 17'b0;

//mem[0] =    { NOP , 3'b000 , 3'b000 , 3'b000, 3'b000 }; //nop
//mem[1] =    { AIU , 3'b001 , 3'b000 , 3'b000, 3'b101 }; //AIU R1 R0 5
//mem[2] =    { AIU , 3'b010 , 3'b000 , 3'b000, 3'b100 }; //AIU R2 R0 4
//mem[3] =    { XOR , 3'b011 , 3'b001 , 3'b010, 3'b000 }; //XOR R3 R1 R2
//mem[4] =   { AND , 3'b100 , 3'b001 , 3'b011, 3'b000 };//AND R4 R1 R3
//mem[5] =   { LSL , 3'b101 , 3'b100 , 3'b000, 3'b011 };//LSL R5 R4 011                                                      
//mem[6] =   { SLT , 3'b101 , 3'b001 , 3'b011, 3'b000 };//SLT R5 R1 R3
//mem[7] =   { SUB , 3'b010 , 3'b101 , 3'b011, 3'b000 };// SUB R2 R5 R3
//mem[8] =   { MOV , 3'b111 , 3'b011 , 3'b000, 3'b000 };//MOV R7 R3
//mem[9] =   { NOT , 3'b110 , 3'b111 , 3'b000, 3'b000 };// NOT R6 R7
//mem[10] =   { ST  , 3'b000 , 3'b010 , 3'b110, 3'b000 };// ST R6 [R2]
//mem[11] =   { LD  , 3'b001 , 3'b010 , 3'b000, 3'b000 };// LD R1 [R2]



//mem[0] =    { NOP , 3'b000 , 3'b000 , 3'b000, 3'b000 }; //nop
//mem[1] =    { IN , 3'b001 , 3'b000 , 3'b000, 3'b000 }; //IN R1 
//mem[2] =    { LSL , 3'b010 , 3'b001 , 3'b000, 3'b100 }; //LSL R2 R1 4
//mem[3] =    { LSR , 3'b010 , 3'b010 , 3'b000, 3'b100 }; //LSL R2 R2 4
//mem[4] =   { LSR , 3'b011 , 3'b001 , 3'b000, 3'b100 }; //LSL R2 R2 4
//mem[5] =   { OUT , 3'b000 , 3'b010 , 3'b011, 3'b000 };//LSL R5 R4 011                                                      
//mem[6] =   { JMR , 3'b000 , 3'b000 , 3'b000, 3'b000 };//SLT R5 R1 R3






//mem[0] =    { NOP , 3'b000 , 3'b000 , 3'b000, 3'b000 }; //jmp r0
//mem[1] =    { AIU , 3'b001 , 3'b000 , 3'b000, 3'b001 }; //AIU R1 R0 1
//mem[2] =    { AIU , 3'b010 , 3'b000 , 3'b000, 3'b001 }; //AIU R2 R0 1
//mem[3] =    { AIU , 3'b011 , 3'b000 , 3'b000, 3'b001 }; //AIU R1 R0 1
//mem[4] =    { JMR , 3'b000 , 3'b001 , 3'b000, 3'b000 }; //jmp r0
//mem[5] =    { NOP , 3'b000 , 3'b000 , 3'b000, 3'b000 }; //jmp ADD
//mem[6] =    { NOP , 3'b000 , 3'b000 , 3'b000, 3'b000 }; //jmp r0




//end

//assign prodata = mem[address];
//endmodule
    
   
    
     
    //data value is finally assigned
    

