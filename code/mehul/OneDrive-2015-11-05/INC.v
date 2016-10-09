module INC (T3_INC, T3_out);
input wire [15:0]T3_out;
output reg [15:0]T3_INC;

always @ (*)
begin
T3_INC= T3_out +1;
end
endmodule
