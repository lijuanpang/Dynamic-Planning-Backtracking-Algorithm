

%最小路径
function[p_opt,fval]=dynprog(x,DecisFun,ObjFun,TransFun)
k=length(x(1,:));%第一行，所有列的数据长度，标记从1开始
x_isnan=~isnan(x);%~isnan函数的作用是如果x中有非数（NaNs，比如0/0），则取0，否则取1
f_vub=inf;%无穷大量+∞，同样地，-∞可以表示为-Inf。即使遇到了以0为除数的运算，而只给出一个“除0”警告，并将结果赋成Inf，继续
f_opt=nan*ones(size(x));%具有与x同样行和列的矩阵，矩阵中每个值均为 NaN
d_opt=f_opt;
t_vubm=inf*ones(size(x));%具有与x同样行和列的矩阵，矩阵中每个值均为 inf
%以下计算最后阶段的相关值
tmp1=find(x_isnan(:,k));%状态矩阵x中k列除非数（NaNs，比如0/0）外，其他k阶段可选状态的位置，比如1,3，表示k列的第一行与第三行
tmp2 = length(tmp1);%k阶段中可选状态的数量，这里感觉有点不对，不应该是tmp1直接参与循环的吗
for i=1:tmp2 
    u=feval(DecisFun,k,x(i,k));%feval简单的说就是执行函数句柄fhandle，参数为x1-xn
    tmp3=length(u);%在该阶段该状态变量下求出的相应允许决策变量的函数
    for j=1:tmp3%将决策变量逐个代入求解
        tmp=feval(ObjFun,k,x(tmp1(i),k),u(j));%目标函数,tmp1(i)表i位置中的数字，也就是行数
        if tmp<=f_vub
            f_opt(i,k)=tmp;%相应的目标值放入该位置
            d_opt(i,k)=u(j)%相应的决策变量值
            t_vub=tmp;%不懂
        end
    end
end
