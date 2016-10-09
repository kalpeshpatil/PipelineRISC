module se3_16(in,out);
input wire [2:0] in;
output reg [15:0] out;
reg [12:0] pad = 13'b0;	

always @(*) 
begin 
	out = {pad,in};
end
endmodule

