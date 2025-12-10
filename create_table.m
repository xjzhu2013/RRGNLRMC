function[t1,t2,t3,t4,t5]=create_table()
filenames={'fm5kr70_1.mat','fm5kr70_2.mat','fm5kr70_3.mat','fm5kr70_4.mat'...
   , 'fm5kr70_5.mat'};
numfiles=length(filenames);
t1=0; t2=0; t3=0; t4=0; t5=0; 
grad1=0; grad2=0; grad3=0; grad4=0; grad5=0; 
rec1=0; rec2=0; rec3=0; rec4=0; rec5=0; 
itr1=0; itr2=0; itr3=0; itr4=0; itr5=0; 
icg1=0; icg2=0; icg3=0; icg4=0; icg5=0; 
for i=1:numfiles
data=load(filenames{i});

t1=t1+data.out1.t;
grad1=grad1+data.out1.normGrad;
rec1=rec1+data.out1.recovery;
itr1=itr1+data.out1.itr;
icg1=icg1+data.out1.count;

t2=t2+data.out2.t;
grad2=grad2+data.out2.normGrad;
rec2=rec2+data.out2.recovery;
itr2=itr2+data.out2.itr;
icg2=icg2+data.out2.count;

t3=t3+data.out3.t;
grad3=grad3+data.out3.normGrad;
rec3=rec3+data.out3.recovery;
itr3=itr3+data.out3.itr;

t4=t4+data.out4.t;
grad4=grad4+data.out4.normGrad;
rec4=rec4+data.out4.recovery;
itr4=itr4+data.out4.itr;

t5=t5+data.out_ARNT.time;
grad5=grad5+data.out_ARNT.nrmG;
icg5=icg5+sum(data.out_ARNT.iter_sub);
itr5=itr5+data.out_ARNT.iter;
rec5=rec5+data.out_ARNT.recovery;
end
t1=t1/numfiles; t2=t2/numfiles; t3=t3/numfiles;
t4=t4/numfiles; t5=t5/numfiles; 

grad1=grad1/numfiles; grad2=grad2/numfiles; grad3=grad3/numfiles;
grad4=grad4/numfiles; grad5=grad5/numfiles; 

rec1=rec1/numfiles; rec2=rec2/numfiles; rec3=rec3/numfiles;
rec4=rec4/numfiles; rec5=rec5/numfiles; 

itr1=itr1/numfiles; itr2=itr2/numfiles; itr3=itr3/numfiles;
itr4=itr4/numfiles; itr5=itr5/numfiles; 

icg1=icg1/numfiles; icg2=icg2/numfiles; icg3=icg3/numfiles;
icg4=icg4/numfiles; icg5=icg5/numfiles; 

identifier = {'T'; 'grad';'recovery';'itr';'icg'};  % 第一行标识为T，第二行标识为grad
data = [t1, t2, t3, t4, t5;  % 第一行数据
        grad1, grad2, grad3, grad4, grad5;
        rec1,rec2,rec3,rec4,rec5;
        itr1,itr2,itr3,itr4,itr5;
        icg1,icg2,icg3,icg4,icg5]; % 第二行数据
colNames = {'Identifier', 'out1', 'out2', 'out3', 'out4', 'out5'};  % 列标题

% 创建表格对象
dataTable = table(identifier, data(:,1), data(:,2), data(:,3), data(:,4), data(:,5), ...
                 'VariableNames', colNames);

% 写入Excel文件
filename = 'fm5kr70.xlsx';
writetable(dataTable, filename);

% 显示结果
disp('Excel文件已生成:');
disp(filename);
disp('文件内容:');
disp(dataTable);
end