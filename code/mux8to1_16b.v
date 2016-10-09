module mux8to1_16b(ip0,ip1,ip2,ip3,ip4,ip5,ip6,ip7,ctrl_sig,op);
input wire [15:0] ip0,ip1,ip2,ip3,ip4,ip5,ip6,ip7;
input wire [2:0]ctrl_sig;
output reg [15:0]op;

always @ (*) 
begin
	case (ctrl_sig)
			3'b000:
			begin
				op=ip0;
			end
	
		3'b001:
			begin
				op=ip1;
			end
		3'b010:
			begin
				op=ip2;
			end
		3'b011:
			begin
				op=ip3;
			end
			3'b100:
			begin
				op=ip4;
			end
			3'b101:
			begin
				op=ip5;
			end
			default:
			begin
				op=3'b000;
			end
endcase
end
endmodule
