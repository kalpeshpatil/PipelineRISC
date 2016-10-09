module mux2to1_16b(ip0, ip1, ctrl_sig, op);
input wire [15:0] ip1, ip0;
input wire ctrl_sig;
output reg [15:0] op;
always @(*)
begin
 op = (ctrl_sig) ? ip1: ip0;
 end
endmodule
