module Inst_Memory(PC_Out, IR_FD_in);
input wire [15:0]PC_Out;
output reg [15:0]IR_FD_in;
reg [15:0]Inst_memory[0:31];

always @ (*)
begin
IR_FD_in= Inst_memory[PC_Out];
end
endmodule 