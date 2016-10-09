module RegisterFile( A1,A2,A3,RF1,RF2,RF3,RF4,reset, clk, rf3_wr_en, rf4_wr_en,
							R0, R1, R2, R3, R4, R5, R6, R7);

integer i;
input  wire [2:0] A1,A2,A3;
input wire reset, clk, rf3_wr_en, rf4_wr_en;
input wire [15:0] RF3,RF4;
output reg [15:0] RF1,RF2;
reg [15:0] register [0:7];
output wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7;
assign R0 = register[0];
assign R1 = register[1];
assign R2 = register[2];
assign R3 = register[3];
assign R4 = register[4];
assign R5 = register[5];
assign R6 = register[6];
assign R7 = register[7];

initial
begin
register[0]=16'd0;
register[1]=16'd0;
register[2]=16'd0;
register[3]=16'd0;
register[4]=16'd0;
register[5]=16'd0;
register[6]=16'd0;
register[7]=16'd0;
end

always @(*)
begin
	if(!reset && (!rf3_wr_en || (rf3_wr_en &&(A3!=A1) )))
	begin
		RF1 <= register[A1];
	end
	else if (rf3_wr_en &&(A3==A1)&&(A1!=7) )begin
		RF1 <= RF3;
	end
	else if (A1==7)begin
		RF1 <= RF4;
	end
	
end

always @(*)
begin
	if(!reset && (!rf3_wr_en || (rf3_wr_en &&(A3!= A2) )))
	begin
		RF2 <= register[A2];
	end
	else if (rf3_wr_en &&(A3==A2)&&(A2!=7) )begin
		RF2 <= RF3;
	end
	else if (A1==7)begin
		RF2 <= RF4;
	end
end

always @(posedge clk)
begin
	if(!reset && rf3_wr_en)begin
		register [A3] <= RF3;
	end
	if(!reset && rf4_wr_en && A3 !=7)begin
	register[7]<=RF4;
	end
	if(reset) begin
	 for (i = 0; i<8; i = i+1) begin
		register [i] <= 16'b0;
		end
	end
end
endmodule
