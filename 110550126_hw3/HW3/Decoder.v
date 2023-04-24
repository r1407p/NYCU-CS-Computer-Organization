module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o );
     
//I/O ports
input	[6-1:0] instr_op_i;

output			RegWrite_o;
output	[3-1:0] ALUOp_o;
output			ALUSrc_o;
output			RegDst_o;
//Internal Signals
reg	[3-1:0] ALUOp_o;
reg			ALUSrc_o;
reg			RegWrite_o;
reg			RegDst_o;

//Main function
/*your code here*/
always @(*)begin
    if(instr_op_i == 6'b000000)begin
        
        ALUOp_o = 3'b010; //rformat
		ALUSrc_o = 1'b0;
		RegWrite_o = 1'b1;
		RegDst_o = 1'b1; 
    end
    if(instr_op_i == 6'b001000)begin
        ALUOp_o = 3'b000; //addi
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		RegDst_o = 1'b0;
    end

end
/*
wire R, lw ,sw,beq;
assign R   = (-instr_op_i[5]) & (-instr_op_i[4]) & (-instr_op_i[3]) & (-instr_op_i[2]) & (-instr_op_i[1]) & (-instr_op_i[0]);
assign lw  = ( instr_op_i[5]) & (-instr_op_i[4]) & (-instr_op_i[3]) & (-instr_op_i[2]) & ( instr_op_i[1]) & ( instr_op_i[0]);
assign sw  = ( instr_op_i[5]) & (-instr_op_i[4]) & ( instr_op_i[3]) & (-instr_op_i[2]) & ( instr_op_i[1]) & ( instr_op_i[0]);
assign beq = (-instr_op_i[5]) & (-instr_op_i[4]) & (-instr_op_i[3]) & ( instr_op_i[2]) & (-instr_op_i[1]) & (-instr_op_i[0]);
assign RegDst_o = R;
assign ALUSrc_o = lw | sw;
assign RegWrite_o  = R |lw;
assign ALUOp_o[2] = 1'b0;
assign ALUOp_o[1] = R;
assign ALUOp_o[0] = beq;
*/
endmodule
   