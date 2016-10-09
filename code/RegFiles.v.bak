module RegisterFile( A1,A2,A3,RF1,RF2,RF3,RF4,reset, clk, rf3_wr_en, rf4_wr_en);

integer i;
input [2:0] A1,A2,A3;
input reset, clk, rf3_wr_en, rf4_wr_en;
input [15:0] RF3,RF4;
output reg [15:0] RF1,RF2;
reg [15:0] register [0:7];

always @(*)
begin
	if(!reset && (!rf3_wr_en || (rf3_wr_en &&(A1 != A2)) || !rf4_wr_en || (rf4_wr_en &&(A1!=A2))))
	begin
		RF1 <= register[A1];
	end
end

always @(*)
begin
	if (!reset && (!rf3_wr_en || (rf3_wr_en &&(A1 != A2)) || !rf4_wr_en || (rf4_wr_en &&(A1!=A2))))
	begin
		RF2 <= register[A2];
	end
end

always @(posedge clk)
begin
	if(!reset && rf3_wr_en)begin
		register [A3] <= RF3;
	end
	else if(!reset && rf4_wr_en)begin
	register[7]<=RF4;
	end
	else if(reset) begin
	 for (i = 0; i<8; i = i+1) begin
		register [i] <= 16'b0;
		end
	end
end
endmodule
