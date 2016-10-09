module se97_16(in,out);
input wire [8:0] in;
output reg [15:0] out;
reg [6:0] pad = 7'b0;	

always @(*) 
begin 
	out = {in,pad};
end
endmodule