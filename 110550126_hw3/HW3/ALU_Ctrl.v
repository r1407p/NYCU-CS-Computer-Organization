module ALU_Ctrl( funct_i, ALUOp_i, ALU_operation_o, FURslt_o );

//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALU_operation_o;  
output     [2-1:0] FURslt_o;
     
//Internal Signals
reg		[4-1:0] ALU_operation_o;
reg		[2-1:0] FURslt_o;

//Main function
/*your code here*/
/*
ALUOp_i = 010 --> R
ALUOp_i = 000 --> addi
*/
/*
ALU_operation_o = invertA invertB OP[1] OP[0]
*/
always @(*)begin
    if(ALUOp_i == 3'b000)begin//addi
        FURslt_o =2'b00;  // 
        ALU_operation_o = 4'b0000;
    end
    else begin
        case(funct_i)
            6'b010010:begin//add
            ALU_operation_o = 4'b0010;
            FURslt_o = 2'b00;
        end
        6'b010000:begin//sub
            ALU_operation_o = 4'b0110;
            FURslt_o = 2'b00;
        end
        6'b010100:begin//and
            ALU_operation_o = 4'b0001;
            FURslt_o = 2'b00;
        end
        6'b010110:begin//or
            ALU_operation_o = 4'b0000;
            FURslt_o = 2'b00;
        end
        6'b010101:begin//nor
            ALU_operation_o = 4'b1101;
            FURslt_o = 2'b00;
        end
        6'b100000:begin//slt
            ALU_operation_o = 4'b0111;
            FURslt_o = 2'b00;
        end
        6'b000000:begin//sll//leftright = 1 (in shifter)
            ALU_operation_o = 4'b0001;
            FURslt_o = 2'b01;
        end
        6'b000010:begin//srl//leftright = 0 (in shifter)
            ALU_operation_o = 4'b0000;
            FURslt_o = 2'b01;
        end
        endcase
    end
end
endmodule     
