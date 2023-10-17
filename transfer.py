import os
import pandas as pd
import numpy as np
import re

ds_path = input('请输入路径：')
L = []
H = []
flag = 0
axs = []
for k in os.listdir(ds_path):
    ds_path1 = ds_path + '/' + k
    for i in os.listdir(ds_path1):
        # 数据读取，预处理
        inp = np.array(pd.read_csv(ds_path1+'/'+ i +'/testing.data'))
        l = []
        for j in range(len(inp)-1):
            h = str(inp[j])
            x = re.split('\s+',h)[1:]
            x[-1] = x[-1][:-2]
            l.append(x[1:])
        l = np.array(l,dtype=float)
        l = l.flatten() # 降维
        l = list(l)

        # 能量信息
        ene = np.array(pd.read_csv(ds_path1+'/'+ i +'/input.data'))
        for j in ene:
            if j[0][:6] == 'energy':
                x = float(j[0][8:])
        l.append(x)

        # 带隙
        # bd_gap = np.array(pd.read_csv(ds_path1+'/'+ i +'/BAND_GAP'))
        # x = float(str(bd_gap[1])[28:-2])
        # l.append(x)

        # 设置列标题


        l = np.array(l)

        # 拼接
        if flag == 0:
            L = l
            H.append(i)
            flag += 1

        else:
            try:
                L = np.c_[L,l]
                H.append(i)
                print(i)
            except:
                axs.append(i)
L = pd.DataFrame(L)
    #L.to_excel('2T-ring2.xlsx')
L.columns = H
print(axs)
print(len(axs))
L.to_csv('d.csv')
#L.to_excel('3T.xlsx')