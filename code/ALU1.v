module ALU1(
 In_ALU_opcode,
 In_ALUA_data,
 In_ALUB_data,
 Out_ALU_CFlag,
 Out_ALU_ZFlag,
 Out_ALU_result,
 In_reset
 );
 input [5:0] In_ALU_opcode;
 input wire [15:0] In_ALUA_data;
 input wire [15:0] In_ALUB_data;
 output reg Out_ALU_CFlag;
 output reg Out_ALU_ZFlag;
 output reg [15:0] Out_ALU_result;
 input In_reset;
 
 parameter nop = 2'b00;
 parameter add = 2'b01;
 parameter comp = 2'b10;
 parameter nan = 2'b11;
 
 always @(*)
 begin
	case (In_ALU_opcode[5:4])
		2'b00:
		begin end
		2'b01:
		begin
			if(In_ALU_opcode[3])
			 begin
				{Out_ALU_CFlag, Out_ALU_result} = In_ALUA_data + In_ALUB_data;
			 end
			 else begin
				Out_ALU_result = In_ALUA_data + In_ALUB_data;
			 end
			if(In_ALU_opcode[2]) begin
				if(Out_ALU_result == 0) Out_ALU_ZFlag = 1;
				else Out_ALU_ZFlag = 0;
			end
		end
		2'b10:
		begin
			if(In_ALU_opcode[3])
			 begin
				{Out_ALU_CFlag, Out_ALU_result} = ~(In_ALUA_data && In_ALUB_data);
			 end
			 else begin
				Out_ALU_result = In_ALUA_data + In_ALUB_data;
			 end
			if(In_ALU_opcode[2]) begin
				if(Out_ALU_result == 0) Out_ALU_ZFlag = 1;
				else Out_ALU_ZFlag = 0;
			end
		end
		2'b11:
		begin
			if(In_ALUA_data == In_ALUB_data) Out_ALU_ZFlag = 1;
			else Out_ALU_ZFlag = 0;
		end
	endcase
	
	if(In_reset) begin
   Out_ALU_CFlag = 0;
	Out_ALU_ZFlag = 0;
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
