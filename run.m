
for i=1:10
m=2500;    
n=2500;   
r=50;
maxitr=5000;
filenames1=sprintf('fm2k5r50_%d.mat',i);
load(filenames1);
%[A,B,X0,U,S,V,gtol,~,row,col,ind,mask,r] = generate1(m,n,r, '14.png');

[out1,~]=RRGN(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out2,~]=RRN(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out3,~]=RCG(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out4,~]=RGD(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out_ARNT,X]=test_lrmc(A,U,S,V,mask);

B=mask.*A;
save(filenames1,'A','B','X0','U','S','V','gtol','r','ind','row','col','mask','out1','out2','out3','out4','out_ARNT');
%save(filenames1,'A','B','X0','U','S','V','gtol','maxitr','r','ind','row','col','mask','out2');
end
% for i=1:10
% m=10000;
% n=10000;     
% r=50;
% generateX;
%  [out1,~]=RRANCG(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
%   [out2,~]=RRENCG(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
%   [out3,~]=RCG(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
%   [out4,~]=RGD(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
%  [out_ARNT,X]=test_lrmc(A,U,S,V,mask);
% filenames1=sprintf('m10kr50_%d.mat',i);
% save(filenames1,'A','X0','U','S','V','gtol','maxitr','r','ind','row','col','mask','out1','out2','out3','out4','out_ARNT');
% %save(filenames1,'A','X0','U','S','V','gtol','maxitr','r','ind','row','col','mask','out1');
% end
% r=30;
% generateX;
%  [out1,~]=RRANCG(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
%   [out2,~]=RRENCG(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
%   [out3,~]=RCG(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
%   [out4,~]=RGD(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
%  [out_ARNT,X]=test_lrmc(A,U,S,V,mask);
% filenames1=sprintf('m10kr30_%d.mat',i);
% save(filenames1,'A','X0','U','S','V','gtol','maxitr','r','ind','row','col','mask','out1','out2','out3','out4','out_ARNT');
% end
% 
