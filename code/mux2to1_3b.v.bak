module mux2to1_3b (ip0,ip1, ctrl_sig, op);
input wire [2:0] ip1,ip0;
input wire  ctrl_sig ;
output reg [2:0] op;
 
always @(*)
begin
case(ctrl_sig)
 1:begin op=ip1; end
 0:begin op=ip0; end
endcase
end
endmodule
	