module Inst_Memory(PC_Out, IR_FD_in);
input wire [15:0]PC_Out;
output reg [15:0]IR_FD_in;
reg [15:0]Inst_memory[0:63];

always @ (*)
begin
IR_FD_in= Inst_memory[PC_Out];
end
initial begin
//This portion works for add forwarding
//Inst_memory [0] = 16'b0000000001101000; //R0 + R1 = R5
//Inst_memory [1] = 16'b0000000001111000; //R0 + R1 = R7
////Inst_memory [0] = 16'b1100000001001010; //BEQ 
////Inst_memory [1] = 16'b1100000001000100; //BEQ with jump
////Inst_memory [2] = 16'b0001000110000010; //flush
////Inst_memory [3] = 16'b0101000000000000; //flush
////Inst_memory [4] = 16'b0000000000000000; //flush
//Inst_memory [2] = 16'b0000001010100000; //R1 + R2 = R4
//Inst_memory [3] = 16'b0000000000000000; // R0 + R0 = R0
//Inst_memory [4] = 16'b0000100100101000; //R4 + R4 = R5
//Inst_memory [5] = 16'b0000101001010000; //R5 + R1 = R2

//LM is working
//Inst_memory [0] = 16'b0110110011100100; //LM R6, 1110010
//Inst_memory [1] = 16'b0000000000000000; //

//forwarding with load stall working
//Inst_memory [0] = 16'b0110110011100100; //LM R6, 1110010
//Inst_memory [1] = 16'b0100000110000011; //Load R0 with R6 + 3
//Inst_memory [2] = 16'b0000000110001000; //R1 = R0 + R6

//load, store working
//Inst_memory [0] = 16'b0110110011100100;
//Inst_memory [1] = 16'b0101000110000011; //store R0 value in R6 + 3
//Inst_memory [2] = 16'b0100001110000011; //load R1 with R6 + 3

// SM and LM and ADC
//Inst_memory [0] = 16'b0111110011100100;
//Inst_memory [1] = 16'b0000000000000000;
//Inst_memory [2] = 16'b0000000000000010;
//Inst_memory [3] = 16'b0000001010101000;
//Inst_memory [4] = 16'b0110110011100100;

//JAL 
//Inst_memory [0] =  16'b1000000000011101;  



//My testbench
Inst_memory [0] =  16'b0001110110001010; //ADI R6, R6, 10
Inst_memory [1] =  16'b0001000000001100; //ADI R0, R0, 12 
Inst_memory [2] =  16'b0001001001000011; //ADI R1, R1, 3
Inst_memory [3] =   16'b1000000000001101; //jump to 3 + 13
Inst_memory [16] =  16'b0110110011100100; //LM R6, 1110010
Inst_memory [17] =  16'b0000000000001000; //R1 = R0 + R0
Inst_memory [18] =  16'b0000001010011000; //R3 = R1 + R2 //forwarding
Inst_memory [19] =  16'b0000100100100000; //R4 = R4 + R4;
Inst_memory [19] =  16'b0111110011100100; //SM @R6 11100100
Inst_memory [20] =  16'b0100000110000011; //Load R0 with @(R6 + 3)
Inst_memory [21] =  16'b0000000110001000; //R1 = R0 + R6  //load forwarding stall
Inst_memory [22] =  16'b1100000000001010; //R0 = R0 therefore jump to PC + 10 (32))
Inst_memory [32] =  16'b0011111000000000; //load R7 with 0
end
endmodule 