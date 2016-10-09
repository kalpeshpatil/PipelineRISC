module priority_encoder (enable,inData,vbit,outAddr, temp);
input wire enable;
input wire [8:0] inData;
output wire [8:0] temp;
output reg vbit;
output wire [2:0] outAddr;

initial begin
vbit=0;
end


always @(* ) begin
		if(enable)begin
		vbit = inData[0]|inData[1]|inData[2]|inData[3]|inData[4]|inData[5]|inData[6]|inData[6]|inData[7];
	   end
		else 
		begin
		vbit = 0;
		end
	end
assign   outAddr = ( ! enable) ? 0 : (
      (inData[7]) ? 0 : 
      (inData[6]) ? 1 : 
      (inData[5]) ? 2 : 
      (inData[4]) ? 3 : 
      (inData[3]) ? 4 : 
      (inData[2]) ? 5 : 
      (inData[1]) ? 6 :
	   (inData[0]) ? 7 :	0);
		
assign   temp = ( ! enable) ? 9'b0 : (
      (inData[7]) ? inData&9'b101111111 : 
      (inData[6]) ? inData&9'b110111111 : 
      (inData[5]) ? inData&9'b111011111 : 
      (inData[4]) ? inData&9'b111101111 : 
      (inData[3]) ? inData&9'b111110111 : 
      (inData[2]) ? inData&9'b111111011 : 
      (inData[1]) ? inData&9'b111111101:
	   (inData[0]) ? inData&9'b111111110 :	9'b000000000);
      
			

//always @(* ) begin
//		
//		if(enable)begin
//		vbit = inData[0]|inData[1]|inData[2]|inData[3]|inData[4]|inData[5]|inData[6]|inData[6]|inData[7];
//		  if(inData[7])begin outAddr = 0; temp= inData & 9'b101111111; end
//		  else if (inData[6]) begin outAddr = 1; temp=inData &9'b110111111;  end
//		  else if (inData[5]) begin outAddr = 2; temp= inData & 9'b11101111; end
//		  else if (inData[4]) begin outAddr = 3; temp= inData & 9'b111101111; end
//		  else if (inData[3]) begin outAddr = 4; temp= inData & 9'b111110111; end
//		  else if (inData[2]) begin outAddr = 5; temp= inData & 9'b111111011; end
//		  else if (inData[1]) begin outAddr = 6; temp= inData & 9'b111111101; end
//		  else if (inData[0]) begin outAddr = 7; temp= inData & 9'b111111110; end
//		  else temp=9'b000000000;
//		  
//		end
//end

endmodule
