module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire [32-1:0] instr, PC_i, PC_o, ReadData1, ReadData2, WriteData;
wire [32-1:0] signextend, zerofilled, ALUinput2, ALUResult, ShifterResult;
wire [5-1:0] WriteReg_addr, Shifter_shamt;
wire [4-1:0] ALU_operation;
wire [3-1:0] ALUOP;
wire [2-1:0] FURslt;
wire [2-1:0] RegDst, MemtoReg;
wire RegWrite, ALUSrc, zero, overflow;
wire Jump, Branch, BranchType, MemWrite, MemRead;
wire [32-1:0] PC_add1, PC_add2, PC_no_jump, PC_t, Mux3_result, DM_ReadData;
wire Jr;
assign Jr = ((instr[31:26] == 6'b000000) && (instr[20:0] == 21'd8)) ? 1 : 0;
//modules
/*your code here*/

Program_Counter PC(
        .clk_i(clk_i),      
        .rst_n(rst_n),     
        .pc_in_i(PC_i),//32b
        .pc_out_o(PC_o) //32b
        );
Adder PC_plus_4(
    .src1_i(PC_o), 
    .src2_i(32'd4), 
    .sum_o(PC_add1)//32b
); 
Instr_Memory IM( 
        .pc_addr_i(PC_o), //32b
        .instr_o(instr)//32b
);
Decoder decoder( 
        .instr_op_i(instr[31:26]), //6b
        .RegWrite_o(RegWrite),	
        .ALUOp_o(ALUOP), 
        .ALUSrc_o(ALUSrc), 
        .RegDst_o(RegDst), 
        .Jump_o(Jump), 
        .Branch_o(Branch), 
        .BranchType_o(BranchType), 
        .MemWrite_o(MemWrite), 
        .MemRead_o(MemRead), 
        .MemtoReg_o(MemtoReg)
);

Mux2to1 #(.size(5))instr_to_reg(
        .data0_i(instr[20:16]),//5b
        .data1_i(instr[15:11]),//5b
        .select_i(RegDst[0]),
        .data_o(WriteReg_addr)//5b
);
Reg_File RF( 
        .clk_i(clk_i), 
        .rst_n(rst_n), 
        .RSaddr_i(instr[25:21]), 
        .RTaddr_i(instr[20:16]), 
        .RDaddr_i(WriteReg_addr), 
        .RDdata_i(WriteData), 
        .RegWrite_i(RegWrite), 
        .RSdata_o(ReadData1), 
        .RTdata_o (ReadData2)
);
Sign_Extend sign_extend( 
        .data_i(instr[15:0]), 
        .data_o(signextend)//32b 
);
Zero_Filled zero_filled( 
        .data_i(instr[15:0]), 
        .data_o(zerofilled)//32b
);
Adder adder_for_branch( 
        .src1_i(PC_add1), 
        .src2_i({signextend[29:0],2'b00}), 
        .sum_o(PC_add2)
);
Mux2to1 #(.size(32))get_alusrc2(
        .data0_i(ReadData2),//32b
        .data1_i(signextend),//32b
        .select_i(ALUSrc),
        .data_o(ALUinput2)//32b
);
ALU alu( 
        .aluSrc1(ReadData1), 
        .aluSrc2(ALUinput2), 
        .ALU_operation_i(ALU_operation), 
        .result(ALUResult), //32b
        .zero(zero), 
        .overflow(overflow) 
);
Shifter shifter( 
        .result(ShifterResult), 
        .leftRight(ALU_operation[0]),
        .shamt(instr[10:6]), 
        .sftSrc(ALUinput2)//32b
);
ALU_Ctrl alu_ctrl( 
        .funct_i(instr[5:0]), 
        .ALUOp_i(ALUOP), 
        .ALU_operation_o(ALU_operation), 
        .FURslt_o(FURslt) 
);

Mux3to1 #(.size(32))select_for_mem( 
        .data0_i(ALUResult), 
        .data1_i(ShifterResult), 
        .data2_i(zerofilled), 
        .select_i(FURslt), 
        .data_o(Mux3_result) 
);
Data_Memory DM(	
        .clk_i(clk_i), 
        .addr_i(Mux3_result), 
        .data_i(ReadData2), 
        .MemRead_i(MemRead), 
        .MemWrite_i(MemWrite), 
        .data_o(DM_ReadData)
);
Mux2to1 #(.size(32))write_for_reg(
        .data0_i(Mux3_result), 
        .data1_i(DM_ReadData), 
        .select_i(MemtoReg[0]), 
        .data_o(WriteData) 
);
wire branch_jump;
Mux2to1 #(.size(1))zero_or_not( 
        .data0_i(zero), 
        .data1_i(~zero), 
        .select_i(BranchType), 
        .data_o(branch_jump) 
);
wire PCSrc;
and get_PCSrc(
        PCSrc,
        Branch,
        branch_jump
);
Mux2to1 #(.size(32))PC_or_branch( 
        .data0_i(PC_add1), 
        .data1_i(PC_add2), 
        .select_i(PCSrc), 
        .data_o(PC_no_jump) //32b
);
Mux2to1 #(.size(32))PC_or_Jump( 
        .data0_i(PC_no_jump), 
        .data1_i({PC_add1[31:28],instr[25:0],2'b00}), 
        .select_i(Jump), 
        .data_o(PC_i) //32b
);
// always @(instr)begin
//     $display("PC,%b",PC_i);
//     $display("instr:%b",instr);
//     $display("Jump,%b",Jump);
// end
endmodule



