import random
if __name__ =="__main__":
    variable = ['00001','00010','00011','00100','00101','00110','00111','01000','01001','01010']
    function_field = ['010010','010000','010100','010110','010101','100000','000000','000010','111111']
    file_out =open("CO_P3_test_data4",'w+')
    T = 100;
    for i in range(10):
        ri = random.randint(-10000,10000)
        ri = format(ri& 0xffff,"016b")
        now  = '001000'+'00000'+variable[i]+str(ri)
        file_out.write(now)
        file_out.write('\n')
    for i in range(T):
        f = random.choice(function_field)
        now = ""
        if f == '111111': #addi
            rs = random.choice(variable)
            rt = random.choice(variable)
            ri = random.randint(-10000,10000)
            ri = format(ri& 0xffff,"016b") 
            now+='001000'+rs+rt+str(ri)
        elif f == '000000' or f =='001000':
            rs = '11111'
            rt = random.choice(variable)
            rd = random.choice(variable)
            shamt = random.randint(32)
            print(shamt)
            shamt = format(shamt,"05b")
            print(shamt)
            now = '000000'+rs+rt+rd+str(shamt)+f;
        else:
            rs = random.choice(variable)
            rd = random.choice(variable)
            rt = random.choice(variable)
            now = '000000'+rs+rt+rd+'00000'+f
        file_out.write(now)
        file_out.write('\n')    
    file_out.close()
    