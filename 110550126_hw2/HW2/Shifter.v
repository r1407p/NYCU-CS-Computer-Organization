` include "MUX.v"
module Shifter( result, leftRight, shamt, sftSrc  );
    
  output wire[31:0] result;
  
  input wire leftRight;/*0:right 1:left*/
  input wire[4:0] shamt;
  input wire[31:0] sftSrc;
  /*your code here*/ 
  assign result = leftRight ? sftSrc << shamt : sftSrc >> shamt;  
endmodule