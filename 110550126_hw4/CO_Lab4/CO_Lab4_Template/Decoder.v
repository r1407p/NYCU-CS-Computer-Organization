module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o, Jump_o, Branch_o, BranchType_o, MemWrite_o, MemRead_o, MemtoReg_o);
     
//I/O ports
input	[6-1:0] instr_op_i;

output			RegWrite_o;
output	[3-1:0] ALUOp_o;
output			ALUSrc_o;
output	[2-1:0]	RegDst_o, MemtoReg_o;
output			Jump_o, Branch_o, BranchType_o, MemWrite_o, MemRead_o;
 
//Internal Signals
reg	[3-1:0] ALUOp_o;
reg			ALUSrc_o;
reg			RegWrite_o;
reg	[2-1:0]	RegDst_o, MemtoReg_o;
reg			Jump_o, Branch_o, BranchType_o, MemWrite_o, MemRead_o;

//Main function
/*your code here*/
always @(instr_op_i)begin
    if(instr_op_i ==6'b100001)begin // lw
        RegWrite_o = 1;
        ALUOp_o = 3'b000;
        ALUSrc_o = 1;
        RegDst_o = 2'b00;
        MemtoReg_o = 2'b01;
        Jump_o = 0;
        Branch_o = 0;
        BranchType_o = 0;//no matter
        MemWrite_o = 0;
        MemRead_o = 1;
    end
    if(instr_op_i ==6'b100011)begin // sw
        RegWrite_o = 0;
        ALUOp_o = 3'b000;
        ALUSrc_o = 1;
        RegDst_o = 2'b00;//no matter
        MemtoReg_o = 2'b00;
        Jump_o = 0;
        Branch_o = 0;
        BranchType_o = 0;//no matter
        MemWrite_o = 1;
        MemRead_o = 0;
    end
    if(instr_op_i ==6'b111011)begin // beq
        RegWrite_o = 0;
        ALUOp_o = 3'b001;
        ALUSrc_o = 0;
        RegDst_o = 2'b00;//no matter
        MemtoReg_o = 2'b00;
        Jump_o = 0;
        Branch_o = 1;
        BranchType_o = 0;
        MemWrite_o = 0;
        MemRead_o = 0;
    end
    if(instr_op_i ==6'b100101)begin // bne
        RegWrite_o = 0;
        ALUOp_o = 3'b110;
        ALUSrc_o = 0;
        RegDst_o = 2'b00; //no matter
        MemtoReg_o = 2'b00;
        Jump_o = 0;
        Branch_o = 1;
        BranchType_o = 1;
        MemWrite_o = 0;
        MemRead_o = 0;
    end
    if(instr_op_i ==6'b100010)begin // jump
        
        RegWrite_o = 0;
        ALUOp_o = 3'b000; //xxx
        ALUSrc_o = 0;
        RegDst_o = 2'b00; //no matter
        MemtoReg_o = 2'b00;
        Jump_o = 1;
        Branch_o = 0;
        BranchType_o = 0;//no matter
        MemWrite_o = 0;
        MemRead_o = 0;
    end
    if(instr_op_i ==6'b000000)begin // R
        RegWrite_o = 1;
        ALUOp_o = 3'b010;
        ALUSrc_o = 0;
        RegDst_o = 2'b01;
        MemtoReg_o = 2'b00;
        Jump_o = 0;
        Branch_o = 0;
        BranchType_o = 0;//no matter
        MemWrite_o = 0;
        MemRead_o = 0;
    end
    if(instr_op_i ==6'b001000)begin // addi
        RegWrite_o = 1;
        ALUOp_o = 3'b011;
        ALUSrc_o = 1;
        RegDst_o = 2'b00;
        MemtoReg_o = 2'b00;
        Jump_o = 0;
        Branch_o = 0;
        BranchType_o = 0;//no matter
        MemWrite_o = 0;
        MemRead_o = 0;
    end
end
endmodule
   