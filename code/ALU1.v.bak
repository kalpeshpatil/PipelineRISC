module ALU(
 In_ALU_opcode,
 In_ALU_funct,
 In_ALU_srcA_data,
 In_ALU_srcB_data,
 Out_ALU_CFlag,
 Out_ALU_ZFlag,
 Out_ALU_Write_en,
 Out_ALU_result,
 In_clock,
 In_reset
 );
 input [2:0] In_ALU_opcode;
 input [1:0] In_ALU_funct;
 input [15:0] In_ALU_srcA_data;
 input [15:0] In_ALU_srcB_data;
 output reg Out_ALU_CFlag;
 output reg Out_ALU_ZFlag;
 output reg Out_ALU_Write_en;
 output reg [15:0] Out_ALU_result;
 input In_clock;
 input In_reset;
 
 parameter add = 3'b000;
 parameter addW = 3'b100;
 parameter nan = 3'b001;
 parameter nanW = 3'b101;
 parameter comp = 3'b010;
 parameter compW = 3'b110;
 

 
 
 always @(*)
 begin
  if(!In_reset) begin
  case(In_ALU_opcode)
	add:
		begin 
		Out_ALU_Write_en = 0;
		if(In_ALU_funct == 2'b11) begin
			{Out_ALU_CFlag, Out_ALU_result} = In_ALU_srcA_data + In_ALU_srcB_data;
			if(Out_ALU_result == 0) Out_ALU_ZFlag =1;
			else Out_ALU_ZFlag =0;
		end
	  if(In_ALU_funct == 2'b10)
			{Out_ALU_CFlag, Out_ALU_result} = In_ALU_srcA_data + In_ALU_srcB_data;
			
	  if(In_ALU_funct == 2'b01)begin
			Out_ALU_result = In_ALU_srcA_data + In_ALU_srcB_data;
			if(Out_ALU_result == 0) Out_ALU_ZFlag =1;
			else Out_ALU_ZFlag =0;
	  end
	  
	  if(In_ALU_funct == 2'b00) begin
			Out_ALU_result = In_ALU_srcA_data + In_ALU_srcB_data;
	  end
  end
   
	nan:
	  begin
	   Out_ALU_Write_en = 0;
		Out_ALU_result = ~(In_ALU_srcA_data && In_ALU_srcB_data);
	  end
  
   comp:
	  begin
	   Out_ALU_Write_en = 0;
		if(In_ALU_srcA_data ==  In_ALU_srcB_data) Out_ALU_ZFlag = 1;
		else Out_ALU_ZFlag = 0;
	  end
	 
	addW:
		begin 
		Out_ALU_Write_en = 1;
		if(In_ALU_funct == 2'b11) begin
			{Out_ALU_CFlag, Out_ALU_result} = In_ALU_srcA_data + In_ALU_srcB_data;
			if(Out_ALU_result == 0) Out_ALU_ZFlag =1;
			else Out_ALU_ZFlag =0;
		end
	  if(In_ALU_funct == 2'b10)
			{Out_ALU_CFlag, Out_ALU_result} = In_ALU_srcA_data + In_ALU_srcB_data;
			
	  if(In_ALU_funct == 2'b01)begin
			Out_ALU_result = In_ALU_srcA_data + In_ALU_srcB_data;
			if(Out_ALU_result == 0) Out_ALU_ZFlag =1;
			else Out_ALU_ZFlag =0;
	  end
	  
	  if(In_ALU_funct == 2'b00) begin
			Out_ALU_result = In_ALU_srcA_data + In_ALU_srcB_data;
	  end
  end
   
	nanW:
	  begin
	   Out_ALU_Write_en = 1;
		Out_ALU_result = ~(In_ALU_srcA_data && In_ALU_srcB_data);
	  end
 
	default:
	  begin 
	  end
	  
  endcase
 end
 
 if(In_reset) begin
   Out_ALU_CFlag = 0;
	Out_ALU_ZFlag = 0;
	Out_ALU_Write_en = 0;
	
 end
 end
endmodule

//module ALUnew (clk, aluA, aluB, opSel, aluOut, zeroFlag,carryFlag);
// input wire clk;
// input wire [15:0] aluA;       //1st input of alu
// input wire [15:0] aluB;		//2nd input	
// input wire [1:0] opSel;      //add, nand, subtract
// output reg [15:0] aluOut;    //result
// output reg zeroFlag;
// output reg carryFlag;
// 
// parameter none = 2'b00;
// parameter add = 2'b01;
// parameter compare = 2'b10;
// parameter nandop = 2'b11;
// 
// always @(*)
// begin
// case(opSel)
//	add:
//	begin
//	{carryFlag, aluOut} = aluA + aluB;
//	end
//	compare:
//		begin
//			if(aluA==aluB) zeroFlag = 1;
//			else zeroFlag = 0;
//		end
//	nandop:
//	   begin
//			aluOut = ~(aluA & aluB);
//		end
//   none:
//	   begin
//		end
//	endcase
//	end
//endmodule
