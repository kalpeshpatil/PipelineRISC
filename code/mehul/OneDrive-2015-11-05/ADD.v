module ADD (PC_out, PC_new);
input wire [15:0]PC_out;
output reg [15:0]PC_new;
 always @ (*)
 begin
 PC_new=PC_out + 1;
 end
 endmodule
 