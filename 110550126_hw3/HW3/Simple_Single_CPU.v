module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles



wire [32-1:0] pc_in;
wire [32-1:0] pc_out;



//modules
Program_Counter PC(
        .clk_i(clk_i),      
	    .rst_n(rst_n),     
	    .pc_in_i(pc_in[31:0]) ,   
	    .pc_out_o(pc_out[31:0]) 
	    );
	
Adder Adder1(
        .src1_i(pc_out[31:0]),     
	    .src2_i(32'b00000000000000000000000000000100),
	    .sum_o(pc_in[31:0])    
	    );
wire [32-1:0] instruction;
Instr_Memory IM(
        .pc_addr_i(pc_out[31:0]),  
	.instr_o(instruction[31:0])    
	);
wire RegDst;
wire [5-1:0]Write_Register;
Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruction[20:16]),
        .data1_i(instruction[15:11]),
        .select_i(RegDst),
        .data_o(Write_Register[4:0])
        );	
wire [32-1:0]WriteData;
wire RegWrite;
wire [32-1:0]Read_data_1;
wire [32-1:0]Read_data_2;
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_n(rst_n) ,     
        .RSaddr_i(instruction[25:21]) ,  
        .RTaddr_i(instruction[20:16]) ,  
        .RDaddr_i(Write_Register[4:0]) ,  
        .RDdata_i(WriteData[31:0])  , 
        .RegWrite_i(RegWrite),
        .RSdata_o(Read_data_1[31:0]) ,  
        .RTdata_o(Read_data_2[31:0])   
        );
wire [3-1:0]ALUOP;
wire ALUSrc;
Decoder Decoder(
        .instr_op_i(instruction[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALUOp_o(ALUOP[2:0]),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst)   
		);
wire [4-1:0]ALU_operation;
wire [2-1:0]FURslt;
ALU_Ctrl AC(
        .funct_i(instruction[5:0]),   
        .ALUOp_i(ALUOP[2:0]),   
        .ALU_operation_o(ALU_operation[3:0]),
        .FURslt_o(FURslt[1:0])
        );
wire [32-1:0]signed_extend;
wire [32-1:0]unsigned_extend;
Sign_Extend SE(
        .data_i(instruction[15:0]),
        .data_o(signed_extend[31:0])
        );

Zero_Filled ZF(
        .data_i(instruction[15:0]),
        .data_o(unsigned_extend[31:0])
        );
wire [32-1:0]outcome_data2;
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(Read_data_2[31:0]),
        .data1_i(signed_extend[31:0]),
        .select_i(ALUSrc),
        .data_o(outcome_data2[31:0])
        );	
wire [32-1:0]ALU_result;
wire ALU_zero;
wire ALU_overflow;
ALU ALU(
		.aluSrc1(Read_data_1[31:0]),
	    .aluSrc2(outcome_data2[31:0]),
	    .ALU_operation_i(ALU_operation[3:0]),
		.result(ALU_result[31:0]),
		.zero(ALU_zero),
		.overflow(ALU_overflow) 
	    );
wire [32-1:0]shifter_result;

Shifter shifter( 
		.result(shifter_result), 
		.leftRight(ALU_operation[0]),
		.shamt(instruction[10:6]),
		.sftSrc(outcome_data2[31:0]) 
		);
		
Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(ALU_result[31:0]),
        .data1_i(shifter_result[31:0]),
		.data2_i(unsigned_extend[31:0]),
        .select_i(FURslt[1:0]),
        .data_o(WriteData[31:0])
        );			

endmodule



