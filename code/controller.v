module controller (clock);

input wire clock;
reg reset;
//PC and FD
reg [15:0] PC;
wire PC_en;
wire [15:0] PC_next, PC_new;
wire [15:0]ALU_PC_out,IR_FD_se6_16,IR_RE_se6_16;
wire [15:0] ALU_PC_A, ALU_PC_B;
wire [2:0] PC_mux_ctrl;
reg [15:0] IR_FD;
wire [15:0] F_D_in;
reg [15:0] PC_FD;
reg flush_FD; 
wire [32:0] F_D;
wire imm9FDctrl;
wire [8:0] imm9FDout;
wire [2:0] Rs2_FD_wire;


//DR
reg [15:0] PC_DR;
reg [2:0] Rs1_DR, Rs2_DR, Rd_DR;
reg [5:0] ALU_op_DR;
reg [8:0] Imm9_DR;
reg R7_dest_DR, flush_DR, load_DR, store_DR, LM_DR, SM_DR;
reg ALU_MuxA_DR;
reg [2:0] ALU_MuxB_DR;
reg a1_ctrl;
wire a2_ctrl;
reg a3_ctrl_DR;
reg [1:0] jump_DR;
wire[57:0] D_R ;
reg [2:0] reg_efct_DR;
wire [2:0] Rs2_DR_wire;

//R/E
reg [15:0] PC_RE, T1, T2;
reg [2:0] Rs1_RE,Rs2_RE,Rd_RE;
reg flush_RE, load_RE, R7_dest_RE, LM_RE, SM_RE, store_RE, a3_ctrl_RE;
reg [8:0] Imm9_RE;
reg ALU_MuxA_RE;
reg [2:0] ALU_MuxB_RE;
reg [5:0] ALU_op_RE;
reg [1:0] jump_RE;
wire [15:0] se97_16out, se79_16out;
wire [15:0] aluA, aluB, aluOut, aluForwardA,aluForwardB;
wire [1:0] forwardCtrlA, forwardCtrlB;
wire [2:0] a1, a2;
wire [15:0] rf1, rf2,rf3;
reg[15:0] rf4;
wire rf3_wr_en;
reg rf4_wr_en;
wire [87:0]R_E;
reg [2:0] reg_efct_RE;

//EM
wire  T3_ctrl, T2_dash_ctrl;
wire [15:0] T2_dash_in;
wire [15:0]T3_inc_out, edbout, T3_in;
wire carry_flag,zero_flag; 
reg [15:0]  T2_dash, T3;
reg [2:0]Rd_EM;
reg LM_EM,SM_EM, flush_EM, R7_dest_EM, load_EM,store_EM,WB_en_EM;
reg a3_ctrl_EM;
reg [1:0] CR;
reg [1:0] jump_EM;
wire [64:0]E_M;
wire mem_en;
reg [2:0] reg_efct_EM;
reg [8:0] Imm9_EM;
wire imm9EMctrl;
wire [8:0] imm9EMout;

// enable signals
wire FD_en,DR_en,RE_en,EM_en,MW_en;

//MW
reg R7_dest_MW,load_MW, flush_MW, store_MW,a3_ctrl_MW,WB_en_MW;
reg [15:0] T4, mdr;
reg[2:0] Rd_MW;
wire [37:0] M_W;
reg LM_MW;
reg [2:0]reg_efct_MW;
wire [2:0] a3_MW_wire;

//Priority Encoder
wire vbit_LM; 
wire [2:0]prio_enc_LM_out_addr;
wire prio_enc_LM_en;
wire [8:0]prio_enc_LM_op;

wire vbit_SM; 
wire [2:0]prio_enc_SM_out_addr;
wire prio_enc_SM_en;
wire [8:0] prio_enc_SM_op;
//flush wires
wire flush_DR_wire, flush_EM_wire, flush_MW_wire, flush_RE_wire, flush_FD_wire;

//PC 
se79_16 signExtender79_16_PC_FD(IR_FD[8:0], IR_FD_se6_16);
se79_16 signExtender79_16_PC_RE(Imm9_RE, IR_RE_se6_16);

mux2to1_16b ALU_PC_MUXA (PC_FD, PC_RE, alu_pc_A_ctrl,ALU_PC_A);
mux2to1_16b ALU_PC_MUXB (IR_FD_se6_16, IR_RE_se6_16, alu_pc_B_ctrl,ALU_PC_B);
mux8to1_16b  PC_mux(PC_new, ALU_PC_out, aluOut, rf2, edbout, 16'b0,16'b0,16'b0,PC_mux_ctrl, PC_next);

assign ALU_PC_out=ALU_PC_A + ALU_PC_B;
assign PC_new = PC + 1;

//
Inst_Memory inst_memory0(PC, F_D_in ); //input output

//F_D

assign F_D[32] = flush_FD;
assign F_D[31:16] = IR_FD;
assign F_D[15:0] = PC_FD;

//D_R

assign D_R = {jump_DR, a3_ctrl_DR, a2_ctrl, a1_ctrl, ALU_MuxA_DR, ALU_MuxB_DR,
						R7_dest_DR, flush_DR, load_DR, store_DR, LM_DR, SM_DR,
						Imm9_DR, ALU_op_DR, Rd_DR, Rs2_DR, Rs1_DR, PC_DR,reg_efct_DR};
	

//

wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7;

mux2to1_3b a1_mux(3'b111, Rs1_DR,a1_ctrl, a1);
//shifted 
mux2to1_3b a2_DR_mux(prio_enc_SM_out_addr, Rs2_FD_wire,a2_ctrl, Rs2_DR_wire);

RegisterFile regFile (a1,Rs2_DR,Rd_MW, rf1, rf2, rf3, rf4, reset, clock, rf3_wr_en, rf4_wr_en,
								R0,R1, R2, R3, R4, R5, R6, R7);




assign R_E={jump_RE,ALU_op_RE,ALU_MuxB_RE,ALU_MuxA_RE,Imm9_RE,
flush_RE, load_RE, R7_dest_RE, LM_RE, SM_RE, store_RE, a3_ctrl_RE,
Rs1_RE,Rs2_RE,Rd_RE, T1, T2,PC_RE,reg_efct_RE};

se97_16 signExtender97_16(Imm9_RE, se97_16out);
se79_16 signExtender79_16(Imm9_RE, se79_16out);
mux2to1_16b aluSrcAMux(16'b0, T1, ALU_MuxA_RE, aluA);
mux8to1_16b aluSrcBMux(16'b1, se97_16out, se79_16out, T2,16'b0,16'b0,16'b0,16'b0, ALU_MuxB_RE, aluB);

mux4to1_16b forwardMuxA(aluA, rf3, T3, 16'b0, forwardCtrlA, aluForwardA);
mux4to1_16b forwardMuxB(aluB, rf3, T3, 16'b0, forwardCtrlB, aluForwardB);


ALU1 alu1(ALU_op_RE,aluForwardA,aluForwardB,carry_flag, zero_flag,aluOut, reset);

mux2to1_16b T3_mux(aluOut,T3_inc_out,T3_ctrl, T3_in);
mux2to1_16b T2_dash_mux(T2, mdr, T2_dash_ctrl, T2_dash_in);

//E/M

assign E_M={a3_ctrl_EM,LM_EM,SM_EM, flush_EM, R7_dest_EM, 
load_EM,store_EM,Rd_EM, T2_dash, T3,WB_en_EM,reg_efct_EM,Imm9_EM};


assign mem_en= (load_EM || store_EM)&&!flush_EM;
Data_memory Data_memory0(T3, T2_dash, mem_en, store_EM, edbout, clock, reset);

assign T3_inc_out= T3 +1;


//M_W

assign M_W={R7_dest_MW,load_MW, flush_MW, store_MW,a3_ctrl_MW,T4, mdr, Rd_MW,WB_en_MW};
//shifted
mux2to1_3b a3_mux_MW( prio_enc_LM_out_addr,Rd_EM, a3_ctrl_EM, a3_MW_wire);
mux2to1_16b WB_mux(T4,mdr, load_MW, rf3);

//changed by me
//assign rf3_wr_en = WB_en_MW && !flush_MW;
//new
assign rf3_wr_en = (!LM_EM && WB_en_MW && !flush_MW) || (LM_EM && WB_en_MW && !flush_EM);

//Prio_enc
priority_encoder prio_enc_LM(prio_enc_LM_en,Imm9_EM, vbit_LM, prio_enc_LM_out_addr, prio_enc_LM_op);
priority_encoder prio_enc_SM(prio_enc_SM_en, IR_FD[8:0], vbit_SM, prio_enc_SM_out_addr, prio_enc_SM_op);

mux2to1_9b imm9FDmux (F_D_in[8:0],prio_enc_SM_op,imm9FDctrl, imm9FDout);
mux2to1_9b imm9EMmux (Imm9_RE,prio_enc_LM_op,imm9EMctrl, imm9EMout);




//forwarding unit
forwarding_unit forwarding_unit_0 (reg_efct_RE, reg_efct_EM,reg_efct_MW, flush_RE, flush_EM,flush_MW,
							load_EM,load_MW,store_RE, Rs1_RE, Rs2_RE, Rd_EM,Rd_MW,
							forwardCtrlA, forwardCtrlB, T2_dash_ctrl);
								

// hazard unit
hazard_unit hazard_unit_0 (IR_FD, flush_FD_wire, flush_DR_wire, flush_RE_wire, flush_EM_wire, flush_MW_wire,
							flush_FD,flush_DR, flush_RE,flush_EM,flush_MW,
						  alu_pc_A_ctrl, alu_pc_B_ctrl, PC_mux_ctrl, 
						  PC_en, FD_en, DR_en, RE_en, EM_en, MW_en, vbit_LM,vbit_SM, T3_ctrl, 
						  R7_dest_RE, R7_dest_EM, R7_dest_MW,load_RE, load_EM, load_MW,LM_RE, LM_EM, LM_MW, SM_DR,SM_EM,
						  jump_DR,jump_RE, jump_EM, imm9FDctrl, imm9EMctrl, 
						  zero_flag, store_RE, reg_efct_RE, reg_efct_EM, Rd_MW, Rd_EM,
						  Rs1_RE, Rs2_RE,prio_enc_LM_en,prio_enc_SM_en);
						  
						  
// initial	
initial begin
#0
PC=0;
end

//initial begin
//#0
//clk = 0;
//#100
//clk = ~clk;
//end


		

assign   Rs2_FD_wire = ( (IR_FD[15:12]==4'b0000 )|| (IR_FD[15:12] == 4'b0010)||
								 (IR_FD[15:12]==4'b1100)||(IR_FD[15:12]==4'b1001)	) ? IR_FD[8:6] : (
      (IR_FD[15:12]==4'b0101) ? IR_FD[11:9] : 3'b000);
assign a2_ctrl= (IR_FD[15:12]==4'b0111) ? 0 :1;
      		
// fetch
always @(posedge clock) 
begin
	if(PC_en) begin
		PC<= PC_next;
	end
	if(FD_en) begin
		PC_FD<=PC;
		IR_FD[15:9]<=F_D_in[15:9];
		IR_FD[8:0]<=imm9FDout;
		flush_FD<=flush_FD_wire;
	end
	else if (IR_FD[15:12]==4'b0111) begin
		IR_FD[8:0]<=imm9FDout;
		end


// decode_logic 
	if (DR_en)begin
		PC_DR<=PC_FD;
		flush_DR<=flush_DR_wire;
	case (IR_FD[15:12])
	4'b0000://ADD,ADC,ADZ
		begin
			Rs1_DR<=IR_FD[11:9];
		//	Rs2_DR<=IR_FD[8:6];
			Rs2_DR<=Rs2_DR_wire;
			Rd_DR<=IR_FD[5:3];
			if(IR_FD[1:0] == 2'b00) begin
				ALU_op_DR <= 6'b011100;
			end
			if(IR_FD[1:0] == 2'b10) begin
				ALU_op_DR <= 6'b011110;
			end
			if(IR_FD[1:0] == 2'b01) begin
				ALU_op_DR <= 6'b011101;
			end
			if(IR_FD[5:3]==7) R7_dest_DR <= 1;
			else begin R7_dest_DR<=0;
			load_DR<=0;
			ALU_MuxA_DR<=1;
			ALU_MuxB_DR<=2'b011;
			a1_ctrl<=1;
			//a2_ctrl<=1;
			a3_ctrl_DR<=1;
			LM_DR<=0;
			SM_DR<=0;
			store_DR<=0;	
			reg_efct_DR<=3'b111;
			jump_DR<=2'b11;
			end
		end
	4'b0010://NDU,NDC,NDZ
		begin
			Rs1_DR<=IR_FD[11:9];
		//	Rs2_DR<=IR_FD[8:6];
			Rs2_DR<=Rs2_DR_wire;
			Rd_DR<=IR_FD[5:3];
			if(IR_FD[1:0] == 2'b00) begin
				ALU_op_DR <= 6'b101100;
			end
			if(IR_FD[1:0] == 2'b10) begin
				ALU_op_DR <= 6'b101110;
			end
			if(IR_FD[1:0] == 2'b01) begin
				ALU_op_DR <= 6'b101101;
			end
			if(IR_FD[5:3]==7) R7_dest_DR <= 1;
			else begin R7_dest_DR<=0;
			load_DR<=0;
			ALU_MuxA_DR<=1;
			ALU_MuxB_DR<=3'b011;
			a1_ctrl<=1;
			//a2_ctrl<=1;
			a3_ctrl_DR<=1;
			LM_DR<=0;
			SM_DR<=0;
			store_DR<=0;	
			reg_efct_DR<=3'b111;
			jump_DR<=2'b11;
			end
		end
	4'b0001://ADI
		begin
			Rs1_DR<=IR_FD[11:9];
			Rs2_DR<=Rs2_DR_wire;
			Rd_DR<=IR_FD[8:6];
			Imm9_DR<={IR_FD[5],IR_FD[5],IR_FD[5],IR_FD[5:0]};
			ALU_op_DR <= 6'b011100;
			if(IR_FD[8:6]==7) R7_dest_DR <= 1;
			else R7_dest_DR<=0;
			load_DR<=0;
			ALU_MuxA_DR<=1;
			ALU_MuxB_DR<=3'b010;
			a1_ctrl<=1;
			a3_ctrl_DR<=1;
			LM_DR<=0;
			SM_DR<=0;
			store_DR<=0;
			reg_efct_DR<=3'b101;
			jump_DR<=2'b11;
		end
	4'b0011://LHI
		begin
			Rd_DR<=IR_FD[11:9];
			Rs2_DR<=Rs2_DR_wire;
			Imm9_DR<=IR_FD[8:0];
			ALU_op_DR <= 6'b011100;
			if(IR_FD[11:9]==7) R7_dest_DR <= 1;
			else R7_dest_DR<=0;
			load_DR<=0;
			ALU_MuxA_DR<=0;
			ALU_MuxB_DR<=3'b010;
			a3_ctrl_DR<=1;
			LM_DR<=0;
			SM_DR<=0;
			store_DR<=0;
			reg_efct_DR<=3'b001;
			jump_DR<=2'b11;
		end
	4'b0100://LW
		begin
			Rs1_DR<=IR_FD[8:6];
			Rs2_DR<=Rs2_DR_wire;
			Rd_DR<=IR_FD[11:9];
			Imm9_DR<={IR_FD[5],IR_FD[5],IR_FD[5],IR_FD[5:0]};
			ALU_op_DR <= 6'b010100;
			if(IR_FD[11:9]==7) R7_dest_DR <= 1;
			else R7_dest_DR<=0;
			load_DR<=1;
			ALU_MuxA_DR<=1;
			ALU_MuxB_DR<=3'b010;
			LM_DR<=0;	
			a3_ctrl_DR<=1;
			SM_DR<=0;
			store_DR<=0;
			reg_efct_DR<=3'b101;
			jump_DR<=2'b11;
		end
	4'b0101://SW
		begin
			Rs1_DR<=IR_FD[8:6];
		//	Rs2_DR<=IR_FD[11:9];
			Rs2_DR<=Rs2_DR_wire;
			Imm9_DR<={IR_FD[5],IR_FD[5],IR_FD[5],IR_FD[5:0]};
			ALU_op_DR <= 6'b010011;
			R7_dest_DR<=0;
			load_DR<=0;
			ALU_MuxA_DR<=1;
			ALU_MuxB_DR<=3'b010;
			a1_ctrl<=1;
			//a2_ctrl<=1;
			LM_DR<=0;
			SM_DR<=0;
			store_DR<=1;
			reg_efct_DR<=3'b110;
			jump_DR<=2'b11;
		end
	4'b0110://LM
		begin
			Rs1_DR<=IR_FD[11:9];
			Rs2_DR<=Rs2_DR_wire;
			Imm9_DR<=IR_FD[8:0];
			ALU_op_DR <= 6'b010000;
			if(IR_FD[0]==1) R7_dest_DR <= 1;
			else R7_dest_DR<=0;
			load_DR<=1;
			ALU_MuxA_DR<=1;
			ALU_MuxB_DR<=3'b100;
			a1_ctrl<=1;
			a3_ctrl_DR<=0;
			LM_DR<=1;
			SM_DR<=0;
			store_DR<=0;
			reg_efct_DR<=3'b100;
			jump_DR<=2'b11;
		end
	4'b0111://SM
		begin
			Rs1_DR<=IR_FD[11:9];
			Rs2_DR<=Rs2_DR_wire;
			Imm9_DR<=IR_FD[8:0];
			ALU_op_DR <= 6'b010011;
			R7_dest_DR<=0;
			load_DR<=0;
			ALU_MuxA_DR<=1;
			ALU_MuxB_DR<=3'b100;
			a1_ctrl<=1;
			//a2_ctrl <=0;
			LM_DR<=0;
			SM_DR<=1;
			store_DR<=1;
			reg_efct_DR<=3'b100;
			jump_DR<=2'b11;
		end
		4'b1100://BEQ
		begin
			Rs1_DR<=IR_FD[11:9];
		//	Rs2_DR<=IR_FD[8:6];
			Rs2_DR<=Rs2_DR_wire;
			Imm9_DR<=IR_FD[8:0];
			ALU_op_DR <= 6'b110111;
			R7_dest_DR<=0;
			load_DR<=0;
			ALU_MuxA_DR<=1;
			ALU_MuxB_DR<=3'b011;
			a1_ctrl<=1;
		//	a2_ctrl <=1;
			LM_DR<=0;
			SM_DR<=0;
			store_DR<=0;
			reg_efct_DR<=3'b110;
			jump_DR<=2'b00;
		end	
		4'b1000://JAL
		begin
			Rs1_DR<=7;
			Rs2_DR<=Rs2_DR_wire;
			Rd_DR<=IR_FD[11:9];
			Imm9_DR<=IR_FD[8:0];
			ALU_op_DR <= 6'b010000;
			if(IR_FD[11:9]==7) R7_dest_DR <= 1;
			else R7_dest_DR<=0;
			load_DR<=0;
			ALU_MuxA_DR<=1;
			ALU_MuxB_DR<=3'b000;
			a1_ctrl<=1;
			LM_DR<=0;
			SM_DR<=0;
			store_DR<=0;
			reg_efct_DR<=3'b001;
			jump_DR<=2'b01;
		end	
		4'b1001://JLR
		begin
			Rs1_DR<=7;
		//	Rs2_DR<=IR_FD[8:6];
			Rs2_DR<=Rs2_DR_wire;
			Rd_DR<=IR_FD[11:9];
			Imm9_DR<=IR_FD[8:0];
			ALU_op_DR <= 6'b010000;
			if(IR_FD[11:9]==7) R7_dest_DR <= 1;
			else R7_dest_DR<=0;
			load_DR<=0;
			ALU_MuxA_DR<=1;
			ALU_MuxB_DR<=3'b000;
			a1_ctrl<=1;
		//	a2_ctrl<=1;
			LM_DR<=0;
			SM_DR<=0;
			store_DR<=0;
			reg_efct_DR<=3'b101;
			jump_DR<=2'b10;
		end
	endcase
end
//assigning Rs2_FD_wire

	
	//Register Read logic
	rf4_wr_en<=1;
	rf4<= PC_FD;
	if (!RE_en&&(flush_RE == 0 && LM_RE)) begin
		flush_RE<=flush_RE_wire;
	end
	if(RE_en)begin
		PC_RE<=PC_DR;
		flush_RE<=flush_RE_wire;
		T1<=rf1;
		T2<=rf2;
		a3_ctrl_RE<=a3_ctrl_DR;
		Imm9_RE<=Imm9_DR;
		load_RE<=load_DR;
		R7_dest_RE<=R7_dest_DR;
		LM_RE<=LM_DR;
		SM_RE<=SM_DR;
		store_RE<=store_DR;
		Rs1_RE<=Rs1_DR;
		Rs2_RE<=Rs2_DR;
		Rd_RE<=Rd_DR;
		ALU_MuxA_RE<=ALU_MuxA_DR;
		ALU_MuxB_RE<=ALU_MuxB_DR;
		ALU_op_RE<=ALU_op_DR;
		reg_efct_RE<=reg_efct_DR;
		jump_RE<=jump_DR;
	end
	CR[1]<=carry_flag;
	
	CR[0]<=zero_flag;
	
	//Execute
	if(ALU_op_RE[1:0]==2'b0) WB_en_EM<=1;
	else if(ALU_op_RE[1:0]==2'b10 && CR[1]) WB_en_EM<=1;
	else if(ALU_op_RE[1:0]==2'b10 && !CR[1])WB_en_EM<=0;
	else if(ALU_op_RE[1:0]==2'b01 && CR[0])WB_en_EM<=1;
	else if(ALU_op_RE[1:0]==2'b01 && !CR[0])WB_en_EM<=0;
	else if (ALU_op_RE[1:0]==2'b11) WB_en_EM<=0;
	
	if (!EM_en&&(reg_efct_EM[0]==1 && reg_efct_RE[2]==1 && Rs1_RE==Rd_EM && load_EM
		&&(!flush_EM && !flush_RE)||
		(reg_efct_EM[0]==1 && reg_efct_RE[1]==1 && Rs2_RE==Rd_EM && load_EM
		&&(!flush_EM && !flush_RE))))begin
		flush_EM<=flush_EM_wire;
		end
	if (!EM_en && LM_EM && flush_EM==0)	
	begin
	T3<=T3_in;
	Imm9_EM<=imm9EMout;
	end
	if (SM_EM&& flush_EM==0)
	begin
	T3<=T3_in;
	end
	if(EM_en)begin
	 T3<=T3_in;
	 T2_dash<=T2_dash_in;
	 Rd_EM<=Rd_RE;
	 LM_EM<=LM_RE;
	 SM_EM<=SM_RE;
	 flush_EM<=flush_EM_wire;
	 load_EM<=load_RE;
	 a3_ctrl_EM<=a3_ctrl_RE;
	 store_EM<=store_RE;
	 R7_dest_EM<=R7_dest_RE;
	 reg_efct_EM<=reg_efct_RE;
	 jump_EM<=jump_RE;
	 Imm9_EM<=imm9EMout;
	end
	 
	
//	if(!EM_en && LM_EM && !flush_EM) begin
//		Imm9_EM<= prio_enc_op;
//		T3<=T3_in;
//	end
	
	//Memory
	
	if(MW_en) begin
		mdr<=edbout;
		T4<=T3;
		R7_dest_MW<=R7_dest_EM;
		load_MW<=load_EM;
		store_MW<=store_EM;
		a3_ctrl_MW<=a3_ctrl_EM;
		flush_MW<=flush_MW_wire;
		store_MW<=store_EM;
		WB_en_MW<=WB_en_EM;
		Rd_MW<=a3_MW_wire;
		LM_MW<=LM_EM;
		reg_efct_MW<=reg_efct_EM;
	end
	 
	//write back
	

	end

	
initial begin
	reset = 0;
	Rd_MW = 3'b0;
	Rd_EM = 3'b0;
	Rd_RE = 3'b0;
	Rd_DR = 3'b0;
	
	ALU_op_DR [1:0] = 2'b11;
	WB_en_EM = 0;
	WB_en_MW = 0;
	ALU_op_RE [1:0] = 2'b11;
	
end
endmodule
