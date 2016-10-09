module Data_memory(T3_out, edb_in, mem_en, mem_wr_en, edb_out, clk, reset);
input [15:0] T3_out;
input [15:0] edb_in;
input mem_en, clk, reset;
input mem_wr_en;
reg [15:0]Data_memory [0:31];
output reg [15:0]edb_out;
integer i;
always @(*) begin
 if(!reset && mem_wr_en && mem_en) begin
 edb_out = Data_memory[T3_out];
 end
end

always @(posedge clk)
begin
	if(!reset && !mem_wr_en && mem_en) begin
	Data_memory[T3_out] <= edb_in;
	end
	else if(reset) begin
	 for (i = 0; i<32; i = i+1) begin
		Data_memory[i] <= 16'b0;
		end
	end
end

endmodule
