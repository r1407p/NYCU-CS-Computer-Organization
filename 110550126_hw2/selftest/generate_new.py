import random
input = []
output = []


"""
+
-
and
or
nand
nor
less than 
"""
if __name__ =="__main__":
    op_list = [0b0010, 0b0110, 0b0001, 0b0000, 0b1100, 0b1101, 0b0111]
    T = 100;
    for i in range(1,T+1):
        print(f"+++++++++{i}+++++++++++")
        op = random.choice(op_list)
        aluSrc1 = random.randint(-2**31,2**31-1)
        aluSrc2 = random.randint(-2**31,2**31-1)
        
        # aluSrc1 = 2
        # aluSrc2 = 4
        #op = 0b0110
        
        alu_1=format(aluSrc1 & 0xffffffff, '032b')
        alu_2=format(aluSrc2 & 0xffffffff, '032b')
        
        # print(str(alu_1))
        # print(bin(aluSrc1))
        # print(aluSrc1)
        # print(op)
        overflow = 0
        if op == 0b0010: #add
            result = aluSrc1+aluSrc2
            if aluSrc1 >0 and aluSrc2 >0 and result >= 2147483648:
                overflow =1
            if aluSrc1 <0 and aluSrc2 <0 and result < -2147483648:
                overflow =1
        elif op == 0b0110:#sub
            result =  aluSrc1-aluSrc2
            if aluSrc1 >0 and aluSrc2 <0 and result >= 2147483648:
                overflow = 1
            if aluSrc1 <0 and aluSrc2 >0 and result < -2147483648:
                overflow = 1
        elif op == 0b0001:
            result =  aluSrc1&aluSrc2
        elif op == 0b0000:
            result =  aluSrc1|aluSrc2
        elif op == 0b1100:
            result =  ~(aluSrc1&aluSrc2)
        elif op == 0b1101:
            result =  ~(aluSrc1|aluSrc2)
        elif op == 0b0111:
            temp = aluSrc1-aluSrc2
            if aluSrc1 >0 and aluSrc2 <0 and temp >= 2147483648:
                overflow = 1
            if aluSrc1 <0 and aluSrc2 >0 and temp < -2147483648:
                overflow = 1
            print(temp)
            temp = str(format(temp& 0x1ffffffff,"033b"))
            print(temp)
            if temp[1]=='1':
                result = 1
            else:
                result = 0
        zero = 0
        if result == 0 or result ==4294967296 :
            zero = 1
        print(aluSrc1)
        # print(alu_1)
        print(str(alu_1))
        print(aluSrc2) 
        # print(alu_2)
        print(str(alu_2))
        op = format(op,'04b')
        #print(op)
        print(str(op))
        print(str(op)+str(alu_1)+str(alu_2))
        input_ = str(op)+str(alu_1)+str(alu_2)
        print("==========output================")
        print(result)
        result = format(result& 0x1ffffffff,"033b")
        print(overflow)
        print(zero)
        print(result)
        output_ = str(overflow)+str(zero)+str(result[1:])
        input.append(input_)
        output.append(output_)
    file_in = open("test1_ALU.txt",'w+')
    file_out =open("ans1_ALU.txt",'w+')
    print("++++++++++++++")
    for i in input:
        file_in.write(i+'\n')
    file_in.close()
    print("==========")
    for i in output:
        file_out.write(i+'\n')
    file_out.close()
        