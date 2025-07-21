

m=2000;
n=2000;   
r=10;
generateX;
[out1,~]=RRGN(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out2,~]=RRN(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out3,~]=RCG(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out4,~]=RGD(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out_ARNT,~]=test_lrmc(A,U,S,V,mask);
%filenames1=sprintf('m2kr10_%d.mat',i);
save("m2kr10_1.mat",'A','X0','U','S','V','gtol','maxitr','r','ind','row','col','mask','out1','out2','out3','out4','out_ARNT');

generateX;
[out1,~]=RRGN(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out2,~]=RRN(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out3,~]=RCG(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out4,~]=RGD(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out_ARNT,~]=test_lrmc(A,U,S,V,mask);
%filenames1=sprintf('m2kr10_%d.mat',i);
save('m2kr10_2.mat','A','X0','U','S','V','gtol','maxitr','r','ind','row','col','mask','out1','out2','out3','out4','out_ARNT');

generateX;
[out1,~]=RRGN(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out2,~]=RRN(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out3,~]=RCG(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out4,~]=RGD(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
[out_ARNT,~]=test_lrmc(A,U,S,V,mask);
%filenames1=sprintf('m2kr10_%d.mat',i);
save('m2kr10_3.mat','A','X0','U','S','V','gtol','maxitr','r','ind','row','col','mask','out1','out2','out3','out4','out_ARNT');


