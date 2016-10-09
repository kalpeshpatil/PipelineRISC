module se6_16(in,out);
input wire [5:0] in;
output reg [15:0] out;

reg [9:0] pad 	;

always @(*) 
begin 
   if (in[5])begin
	pad= 10'b1111111111;
	end
	else begin
	pad= 10'b0;
	end
	out = {pad,in};
end
endmodule
