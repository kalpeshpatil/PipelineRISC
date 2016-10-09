module mux4to1_3b (ip0,ip1,ip2,ip3, ctrl_sig, op);
input wire [2:0] ip1,ip2,ip3,ip0;
input wire [1:0] ctrl_sig ;
output reg [2:0] op;
 
always @(*)
begin
case(ctrl_sig)
 2'b01:begin op=ip1; end
 2'b10:begin op=ip2; end
 2'b11:begin op=ip3; end
 2'b00:begin op=ip0; end
endcase
end
endmodule
	