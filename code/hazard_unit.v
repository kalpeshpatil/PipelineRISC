module hazard_unit (IR_FD, flush_FD, flush_DR, flush_RE, flush_EM, flush_MW,
							flush_FD_in,flush_DR_in, flush_RE_in,flush_EM_in,flush_MW_in,
						  ALU_pc_muxA_ctrl, ALU_pc_muxB_ctrl, PC_mux_ctrl, 
						  PC_en, FD_en, DR_en, RE_en, EM_en, MW_en, vbit_LM,vbit_SM, T3_ctrl, 
						  R7_dest_RE, R7_dest_EM, R7_dest_MW,load_RE, load_EM, load_MW,LM_RE, LM_EM, LM_MW, SM_DR,SM_EM,
						  jump_bits_DR,jump_bits_RE, jump_bits_EM, imm9FDctrl, imm9EMctrl, 
						  zero_flag, store_RE, reg_efct_RE, reg_efct_EM, Rd_MW, Rd_EM,
						  Rs1_RE, Rs2_RE,prio_enc_LM_en,prio_enc_SM_en);
						  
input wire [15:0] IR_FD;
input wire vbit_LM, vbit_SM,zero_flag,store_RE;
input wire R7_dest_RE, R7_dest_EM, R7_dest_MW,load_RE, load_EM,load_MW, LM_RE, LM_EM, LM_MW, SM_DR,SM_EM;
input wire [1:0] jump_bits_DR,jump_bits_RE, jump_bits_EM;
input wire [2:0] reg_efct_RE, reg_efct_EM;
input wire [2:0] Rd_EM, Rd_MW,Rs1_RE, Rs2_RE;

input wire flush_FD_in,flush_DR_in, flush_RE_in,flush_EM_in,flush_MW_in;
output reg flush_FD, flush_DR, flush_RE, flush_EM, flush_MW;
output reg ALU_pc_muxA_ctrl, ALU_pc_muxB_ctrl;
output reg [2:0] PC_mux_ctrl;
output reg PC_en,FD_en, DR_en, RE_en, EM_en, MW_en,T3_ctrl;
output reg imm9EMctrl,imm9FDctrl;
output reg prio_enc_LM_en, prio_enc_SM_en;

initial begin
PC_en=1;
FD_en=1;
DR_en=1;
RE_en=1;
EM_en=1;
MW_en=1;
flush_FD=0;
flush_DR=1;
flush_RE=1;
flush_EM=1;
flush_MW=1;
PC_mux_ctrl = 3'b000;
imm9EMctrl=0;
imm9FDctrl=0;
T3_ctrl=0;
ALU_pc_muxA_ctrl=0;
ALU_pc_muxB_ctrl=0;
end		

always @(*)
begin
/// flush ///
	if (R7_dest_MW&&load_MW==1&&flush_MW_in==0) // flush due to  load R7
	begin
		PC_mux_ctrl = 3'b100;
		ALU_pc_muxA_ctrl = 0;
		ALU_pc_muxB_ctrl = 0;
		PC_en = 1;
		flush_FD=1;
		flush_DR=1;
		flush_RE=1;
		flush_EM=1;
		flush_MW=1;
	end
	else if (flush_RE_in==0&&jump_bits_RE==2'b00&&zero_flag) // BEQ
	begin
		PC_mux_ctrl = 3'b001;
		ALU_pc_muxA_ctrl = 1;
		ALU_pc_muxB_ctrl = 1;
		PC_en = 1;
		flush_FD=1;
		flush_DR=1;
		flush_RE=1;
		flush_EM=flush_RE_in;
		flush_MW=flush_EM_in;
	end 
	else if (R7_dest_RE&&load_RE==0&&flush_RE_in==0 
	&&jump_bits_RE==2'b11)// execute R7
	begin
		PC_mux_ctrl = 3'b010;
		ALU_pc_muxA_ctrl = 0;
		ALU_pc_muxA_ctrl = 0;
		PC_en = 1;
		flush_FD=1;
		flush_DR=1;
		flush_RE=1;
		flush_EM=flush_RE_in;
		flush_MW=flush_EM_in;
	end
	else if (flush_DR_in==0&&jump_bits_DR==2'b10) // JLR
	begin
			PC_mux_ctrl = 3'b011;
			ALU_pc_muxA_ctrl = 0;
			ALU_pc_muxA_ctrl = 0;
			PC_en = 1;
			flush_FD=1;
			flush_DR=1;
			flush_RE=flush_DR_in;
			flush_EM=flush_RE_in;
			flush_MW=flush_EM_in;
	end
	else if (flush_FD_in==0&&IR_FD[15:12] == 4'b1000) // JAL
	begin
		flush_FD=1;
			PC_mux_ctrl = 3'b001;
			ALU_pc_muxA_ctrl = 0;
			ALU_pc_muxB_ctrl = 0;
			PC_en = 1;
			flush_DR=flush_FD_in;
			flush_RE=flush_DR_in;
			flush_EM=flush_RE_in;
			flush_MW=flush_EM_in;
	end
	else begin   // default with no hazard
			PC_mux_ctrl = 3'b000;
			ALU_pc_muxA_ctrl = 0;
			ALU_pc_muxA_ctrl = 0;
			PC_en = 1;
			flush_FD=0;
			flush_DR=flush_FD_in;
			flush_RE=flush_DR_in;
			flush_EM=flush_RE_in;
			flush_MW=flush_EM_in;
	end
	
	
//--------------------/// stalls///-----------------------------------------

	//load forwarding stall
	if(reg_efct_EM[0]==1 && reg_efct_RE[2]==1 && Rs1_RE==Rd_EM && load_EM
		&&(!flush_EM_in && !flush_RE_in)||
		(reg_efct_EM[0]==1 && reg_efct_RE[1]==1 && Rs2_RE==Rd_EM && load_EM
		&&(!flush_EM_in && !flush_RE_in))) 
	begin
		PC_en = 0; 
		FD_en = 0;
		DR_en = 0;
		RE_en = 0;
		EM_en = 0;
		flush_EM = 1;		
	end
	else if (reg_efct_EM[0]==1 && reg_efct_RE[2]==1 && Rs1_RE==Rd_EM && load_EM
		&&(flush_EM_in && !flush_RE_in)||
		(reg_efct_EM[0]==1 && reg_efct_RE[1]==1 && Rs2_RE==Rd_EM && load_EM
		&&(flush_EM_in && !flush_RE_in))) 
    begin
		PC_en = 1; 
		FD_en = 1;
		DR_en = 1;
		RE_en = 1;
		EM_en = 1;
		flush_EM = 0;	
	 end
	//LM stall
	if(flush_RE_in == 0 && LM_RE)  begin
			PC_en = 0; 
			FD_en = 0;
			DR_en = 0;
			RE_en = 0;
			EM_en = 1;
			flush_RE = 1;
			end
	if (LM_EM && flush_EM_in==0)
	begin
		prio_enc_LM_en=1;
	end
	else
	begin
		prio_enc_LM_en=0;
	end
	if (flush_EM_in == 0 && LM_EM ) begin
			PC_en = 0; 
			FD_en = 0;
			DR_en = 0;
			RE_en = 0;
			EM_en = 0;
			end
	if (flush_MW_in == 0 && LM_MW ) begin
			if(!vbit_LM) begin
			PC_en = 1; 
			FD_en = 1;
			DR_en = 1;
			RE_en = 1;
			EM_en = 1;
			MW_en = 1;
			end
	end
	
	//SM stall//
	if ( IR_FD[15:12] == 4'b0111&& flush_FD_in==0)
	begin
		prio_enc_SM_en=1;
	end
	else 
	begin
		prio_enc_SM_en = 0;
	end
	if (flush_FD_in == 0 && IR_FD[15:12] == 4'b0111)
	begin
		if(vbit_SM) begin
		PC_en = 0;
		FD_en = 0;
		end
		else 
		begin
		PC_en = 1; FD_en = 1; flush_DR = 1;
		end
	end
	
	//imm9FDctrl
	if (IR_FD[15:12] == 4'b0111 && vbit_SM) begin
		imm9FDctrl = 1;
	end
	else  imm9FDctrl = 0;
	
	//imm9EMctrl
	if (LM_EM && vbit_LM) begin
		imm9EMctrl = 1;
	end
	else  imm9EMctrl = 0;
	
	//T3_ctrl_mux
	if (LM_EM && vbit_LM || SM_EM && flush_EM_in==0) begin
		T3_ctrl = 1;
	end
	else begin T3_ctrl = 0; end	 
	
	
	
	//default values
//	if(
//	!(reg_efct_EM[0]==1 && reg_efct_RE[2]==1 && Rs1_RE==Rd_EM && load_EM
//		&&(!flush_EM_in && !flush_RE_in)||
//		(reg_efct_EM[0]==1 && reg_efct_RE[1]==1 && Rs2_RE==Rd_EM && load_EM
//		&&(!flush_EM_in && !flush_RE_in)))
//		
//	&& !(flush_RE_in == 0 && LM_RE) 
//	&& !(flush_EM_in == 0 && LM_EM )
//	&& !(flush_MW_in == 0 && LM_MW )
//	&& !(flush_FD_in == 0 && IR_FD[15:12] == 4'b0111)
//	)
//	begin
//			PC_en = 1; 
//			FD_en = 1;
//			DR_en = 1;
//			RE_en = 1;
//			EM_en = 1;
//			MW_en = 1;
//	end
end



endmodule