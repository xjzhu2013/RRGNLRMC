function[t1,t2,t3,t4,t5]=average()
filenames={'fm2k5r50_1.mat','fm2k5r50_2.mat','fm2k5r50_3.mat','fm2k5r50_4.mat'...
 'fm2k5r50_5.mat'};
numfiles=length(filenames);
t1=0; t2=0; t3=0; t4=0; t5=0;
grad1=0; grad2=0; grad3=0; grad4=0; grad5=0;
rec1=0; rec2=0; rec3=0; rec4=0; rec5=0;
for i=1:numfiles
data=load(filenames{i});

t1=t1+data.out1.t;

t2=t2+data.out2.t;

t3=t3+data.out3.t;

t4=t4+data.out4.t;

t5=t5+data.out_ARNT.time;

end
t1=t1/numfiles; t2=t2/numfiles; t3=t3/numfiles;
t4=t4/numfiles; t5=t5/numfiles;

grad1=grad1/numfiles; grad2=grad2/numfiles; grad3=grad3/numfiles;
grad4=grad4/numfiles; grad5=grad5/numfiles;

rec1=rec1/numfiles; rec2=rec2/numfiles; rec3=rec3/numfiles;
rec4=rec4/numfiles; rec5=rec5/numfiles;
end