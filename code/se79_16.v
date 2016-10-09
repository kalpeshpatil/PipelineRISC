module se79_16(in,out);
input wire [8:0] in;
output reg [15:0] out;
reg [6:0] pad;

always @(*) 
begin 
if (in[8])begin
	pad= 7'b1111111;
	end
	else begin
	pad= 7'b0;
	end
	out = {pad,in};
end
endmodule
