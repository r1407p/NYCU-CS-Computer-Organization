` include "MUX.v"
module Shifter( result, leftRight, shamt, sftSrc  );
    
  output wire[31:0] result;
  
  input wire leftRight;/*0:right 1:left*/
  input wire[4:0] shamt;
  input wire[31:0] sftSrc;
  /*your code here*/ 
  wire right;
  not n_r(right,leftRight);
  wire neg_right;
  and a0(neg_right,right,sftSrc[31]);
  /*shift 1*/
  wire r_1[31:0];
  wire l_1[31:0];
  
  genvar i;
  generate for(i = 0;i<32;i = i+1)
    and ar1(r_1[i],right,sftSrc[i]);
    and al1(l_1[i],leftRight,sftSrc[i]);
  endgenerate
  wire [31:0]temp_1_result;
  or o_10(temp_1_result[0],l_1[1],neg_right);
  generate for(i = 1;i<31;i= i+1)
    or o_1(temp_1_result[i],r_1[i-1],l_1[i+1]);
  endgenerate
  buf(temp_1_result[31],l_1[30]);
  wire [31:0]result_1;
  generate for(i = 0;i<32;i= i+1)
    MUX_1bit  MUX_1(result_1[i],sftSrc[i],temp_1_result[i],shamt[0]);
  endgenerate 
  /*shift 2*/
  
  /*shift 4*/
  
  /*shift 8*/
  
  /*shift 16*/
   assign result = 32'b0;
endmodule