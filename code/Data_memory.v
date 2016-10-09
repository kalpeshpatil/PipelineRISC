module Data_memory(T3_out, edb_in, mem_en, mem_wr_en, edb_out, clk, reset);
input [15:0] T3_out;
input [15:0] edb_in;
input mem_en, clk, reset;
input mem_wr_en;
reg [15:0]Data_memory [0:31];
output reg [15:0]edb_out;
integer i;
always @(*) begin
 if(!reset && mem_en) begin
 edb_out = Data_memory[T3_out];
 end
end

always @(posedge clk)
begin
	if(!reset && mem_wr_en && mem_en) begin
	Data_memory[T3_out] <= edb_in;
	end
	else if(reset) begin
	 for (i = 0; i<32; i = i+1) begin
		Data_memory[i] <= 16'b0;
		end
	end
end
initial begin
	Data_memory[0]=1;
	Data_memory[1]=0;
	Data_memory[2]=1;
	Data_memory[3]=2;
	Data_memory[4]=3;
	Data_memory[5]=3;
	Data_memory[6]=2;
	Data_memory[7]=1;
	Data_memory[8]=2;
	Data_memory[9]=3;
	Data_memory[10]=15;
	Data_memory[11]=20;
	Data_memory[12]=25;
	Data_memory[13]=30;
	Data_memory[14]=35;
	Data_memory[15]=40;
	Data_memory[16]=45;
	Data_memory[17]=50;
	Data_memory[23]=5;
	Data_memory[24]=10;
	
	
end
endmodule
