module ALU( aluSrc1, aluSrc2, ALU_operation_i, result, zero, overflow );

//I/O ports 
input	[32-1:0] aluSrc1;
input	[32-1:0] aluSrc2;
input	 [4-1:0] ALU_operation_i;

output	[32-1:0] result;
output			 zero;
output			 overflow;

//Internal Signals
reg			 zero;
reg			 overflow;
reg	[32-1:0] result;

//Main function
/*your code here*/
always @(*)begin
      if(ALU_operation_i == 4'b0010)begin//add
        result = aluSrc1+aluSrc2;
        if(aluSrc1[31]==0&&aluSrc2[31]==0&&result[31]==1)begin
            overflow = 1;
        end
        if(aluSrc1[31]==1&&aluSrc2[31]==1&&result[31]==0)begin
            overflow = 1;
        end 
      end
      else if(ALU_operation_i == 4'b0110)begin//sub
        result = aluSrc1-aluSrc2;
        if(aluSrc1[31]==0&&aluSrc2[31]==1&&result[31]==1)begin
            overflow = 1;
        end
        if(aluSrc1[31]==1&&aluSrc2[31]==0&&result[31]==0)begin
            overflow = 1;
        end

      end
      else if(ALU_operation_i == 4'b0001)begin//and
        result = aluSrc1&aluSrc2;
        overflow  = 0 ;
      end
      else if(ALU_operation_i == 4'b0000)begin//or
        result = aluSrc1|aluSrc2;
        overflow  = 0 ;
      end
      else if(ALU_operation_i == 4'b1101)begin//nor
        result = ~(aluSrc1 | aluSrc2);
        overflow  = 0 ;
      end
      else if(ALU_operation_i == 4'b0111)begin//slt
        result = aluSrc1 < aluSrc2 ? 1 : 0;
        overflow  = 0 ;
      end
      else begin
        result = 0;
        overflow = 0;
      end
      
      zero = (result==0)?1:0;
end
endmodule
