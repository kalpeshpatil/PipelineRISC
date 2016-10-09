module forwarding_unit (reg_efct_RE, reg_efct_EM,reg_efct_MW, flush_RE, flush_EM,flush_MW,
							load_EM,load_MW,store_RE, Rs1_RE, Rs2_RE, Rd_EM,Rd_MW,
								forward_muxA_ctrl, forward_muxB_ctrl, T2_dash_ctrl);

input wire [2:0] reg_efct_EM, reg_efct_RE,reg_efct_MW;
input wire flush_EM, flush_RE,flush_MW, load_EM,load_MW,store_RE;
input wire [2:0] Rs1_RE, Rs2_RE, Rd_EM,Rd_MW;
output reg [1:0] forward_muxA_ctrl, forward_muxB_ctrl;
output reg T2_dash_ctrl;

reg tempA, tempB;

initial begin
forward_muxA_ctrl=2'b00;
forward_muxB_ctrl=2'b00;
T2_dash_ctrl=0;
tempA = 0;
tempB = 0;
end


always @(*) begin
tempA = 0; tempB = 0;
 if(store_RE==0) begin 
	if(!flush_EM && !flush_RE)
	begin
		if(reg_efct_EM[0]==1 && reg_efct_RE[1]==1 && Rs2_RE==Rd_EM) begin
			if(!load_EM) begin
			forward_muxB_ctrl = 2'b10;
			tempB = 1;
			end
		end
		if(reg_efct_EM[0]==1 && reg_efct_RE[2]==1 && Rs1_RE==Rd_EM) begin
			if(!load_EM) begin
			forward_muxA_ctrl = 2'b10;
			tempA = 1;
			end
		end		
	end
	if(!flush_MW && !flush_RE)
	begin
		if(reg_efct_MW[0]==1 && reg_efct_RE[1]==1 && Rs2_RE==Rd_MW) begin
			if(load_MW) begin
			forward_muxB_ctrl = 2'b01;
			tempB = 1;
			end
		end
		if(reg_efct_MW[0]==1 && reg_efct_RE[2]==1 && Rs1_RE==Rd_MW) begin
			if(load_MW) begin
			forward_muxA_ctrl = 2'b01;
			tempA = 1;
			end
		end		
	end
	
end
else 
begin
	if(!flush_EM && !flush_RE)
	begin
		if(reg_efct_EM[0]==1 && reg_efct_RE[1]==1 && Rs2_RE==Rd_EM) begin
			if(!load_EM) begin
			forward_muxB_ctrl = 2'b00;
			T2_dash_ctrl = 1;
			end
		end
		if(reg_efct_EM[0]==1 && reg_efct_RE[2]==1 && Rs1_RE==Rd_EM) begin
			if(!load_EM) begin
			forward_muxA_ctrl = 2'b10;
			T2_dash_ctrl = 0;
			tempA = 1;
			end
		end		
	end
	if(!flush_MW && !flush_RE)
	begin
		if(reg_efct_MW[0]==1 && reg_efct_RE[1]==1 && Rs2_RE==Rd_MW) begin
			if(load_MW) begin
			forward_muxB_ctrl = 2'b00;
			T2_dash_ctrl = 1;
			end
		end
		if(reg_efct_MW[0]==1 && reg_efct_RE[2]==1 && Rs1_RE==Rd_MW) begin
			if(load_MW) begin
			forward_muxA_ctrl = 2'b01;
			T2_dash_ctrl = 0;
			tempA = 1;
			end
		end		
	end
	else begin
		forward_muxA_ctrl = 2'b00;
		forward_muxB_ctrl = 2'b00;
		T2_dash_ctrl = 0;
	end
end
	if(!tempA) forward_muxA_ctrl = 2'b00;
	if(!tempB) forward_muxB_ctrl = 2'b00;
end
endmodule
