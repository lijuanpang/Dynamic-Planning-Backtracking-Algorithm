

%��С·��
function[p_opt,fval]=dynprog(x,DecisFun,ObjFun,TransFun)
k=length(x(1,:));%��һ�У������е����ݳ��ȣ���Ǵ�1��ʼ
x_isnan=~isnan(x);%~isnan���������������x���з�����NaNs������0/0������ȡ0������ȡ1
f_vub=inf;%�������+�ޣ�ͬ���أ�-�޿��Ա�ʾΪ-Inf����ʹ��������0Ϊ���������㣬��ֻ����һ������0�����棬�����������Inf������
f_opt=nan*ones(size(x));%������xͬ���к��еľ��󣬾�����ÿ��ֵ��Ϊ NaN
d_opt=f_opt;
t_vubm=inf*ones(size(x));%������xͬ���к��еľ��󣬾�����ÿ��ֵ��Ϊ inf
%���¼������׶ε����ֵ
tmp1=find(x_isnan(:,k));%״̬����x��k�г�������NaNs������0/0���⣬����k�׶ο�ѡ״̬��λ�ã�����1,3����ʾk�еĵ�һ���������
tmp2 = length(tmp1);%k�׶��п�ѡ״̬������������о��е㲻�ԣ���Ӧ����tmp1ֱ�Ӳ���ѭ������
for i=1:tmp2 
    u=feval(DecisFun,k,x(i,k));%feval�򵥵�˵����ִ�к������fhandle������Ϊx1-xn
    tmp3=length(u);%�ڸý׶θ�״̬�������������Ӧ������߱����ĺ���
    for j=1:tmp3%�����߱�������������
        tmp=feval(ObjFun,k,x(tmp1(i),k),u(j));%Ŀ�꺯��,tmp1(i)��iλ���е����֣�Ҳ��������
        if tmp<=f_vub
            f_opt(i,k)=tmp;%��Ӧ��Ŀ��ֵ�����λ��
            d_opt(i,k)=u(j)%��Ӧ�ľ��߱���ֵ
            t_vub=tmp;%����
        end
    end
end
