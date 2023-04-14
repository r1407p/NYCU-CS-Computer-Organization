` include "MUX.v"
` include "Full_adder.v"
module ALU_1bit( result, carryOut, a, b, invertA, invertB, operation, carryIn, less ); 
  
  output wire result;
  output wire carryOut;
  
  input wire a;
  input wire b;
  input wire invertA;
  input wire invertB;
  input wire[1:0] operation;
  input wire carryIn;
  input wire less;
  /*your code here*/
  wire not_a,not_b,true_a,true_b;

  not na(not_a,a);
  not nb(not_b,b);
  MUX_1bit geta(true_a,a,not_a,invertA);
  MUX_1bit getb(true_b,b,not_b,invertB);
//  xor x1(true_a,a,invertA);
//  xor x2(true_b,b,invertB);
  wire in0,in1,in2;
  or o0(in0,true_a,true_b);
  and a0(in1,true_a,true_b);
  Full_adder F1(in2, carryOut, carryIn, true_a, true_b);
  MUX_2bit M2_1(result,in0,in1,in2,less,operation);
endmodule

module ALU_1bit_bottom( result, overflow,set, a, b, invertA, invertB, operation, carryIn, less ); 
  
  output wire result;
  output wire overflow;
  output wire set;
  
  input wire a;
  input wire b;
  input wire invertA;
  input wire invertB;
  input wire[1:0] operation;
  input wire carryIn;
  input wire less;
  wire not_a,not_b,true_a,true_b;

  not na(not_a,a);
  not nb(not_b,b);
  MUX_1bit geta(true_a,a,not_a,invertA);
  MUX_1bit getb(true_b,b,not_b,invertB);


  wire in0,in1,in2;
  or o0(in0,true_a,true_b);
  and a0(in1,true_a,true_b);
  Full_adder F1(in2, carryOut, carryIn, true_a, true_b);
  buf b1(set,in2);
  MUX_2bit M2_1(result,in0,in1,in2,less,operation);
  wire n_op_0,over;
  not nt(n_op_0,operation[0]);
  xor x1(over,carryIn,carryOut);
  and a1(overflow,operation[1],n_op_0,over);
endmodule


