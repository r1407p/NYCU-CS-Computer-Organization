module MUX_1bit(result,a,b,sel);
    input a,b;
    input sel;
    
    output result;
    
    wire ns;
    not n1(ns,sel);
    wire t1,t2;
    and a1(t1,a,ns);
    and a2(t2,b,sel);
    or o1(result,t1,t2);
endmodule

module MUX_2bit(result,a,b,c,d,sel);
    input a,b,c,d;
    input [1:0]sel;
    output result;
    wire ns_0,ns_1;
    
    not n0 (ns_0,sel[0]);
    not n1 (ns_1,sel[1]);
    
    wire t0,t1,t2,t3;
    and a0(t0,a,ns_1,ns_0);
    and a1(t1,b,ns_1,sel[0]);
    and a2(t2,c,sel[1],ns_0);
    and a3(t3,d,sel[1],sel[0]);
    
    or op(result,t1,t2,t3,t4);
endmodule