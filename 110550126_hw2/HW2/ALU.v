` include "ALU_1bit.v"
module ALU( result, zero, overflow, aluSrc1, aluSrc2, invertA, invertB, operation );

  output wire[31:0] result;
  output wire zero;
  output wire overflow;

  input wire[31:0] aluSrc1;
  input wire[31:0] aluSrc2;
  input wire invertA;
  input wire invertB;
  input wire[1:0] operation;
  
   
  /*your code here*/
   wire carry[31:0];
   wire set;
    genvar i ;
   /*result*/
   ALU_1bit ALU0(result[0], carry[0], aluSrc1[0], aluSrc2[0], invertA, invertB, operation, invertB,set);
   generate for(i = 1;i<31;i = i+1)
        ALU_1bit ALU1(result[i],carry[i],aluSrc1[i],aluSrc2[i],invertA,invertB,operation,carry[i-1],1'b0);
   endgenerate
   ALU_1bit_bottom ALU2(result[31],overflow,set, aluSrc1[31], aluSrc2[31], invertA, invertB, operation, carry[30], 1'b0 );
   /*zero*/
   wire or_output[31:0];
   or o1(or_output[1],result[0],result[1]);
   generate for(i = 2;i<32;i= i+1)
     or or_for_zero(or_output[i],or_output[i-1],result[i]);
   endgenerate
   not get_zero(zero,or_output[31]);
   
endmodule