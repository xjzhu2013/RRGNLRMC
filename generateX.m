
OS=3;
gtol=1.0e-11;
maxitr=5000;
sparsity=(OS*r*(2*n-r))/(m*n);
mask=sprandn(m,n,sparsity);
[row,col]=find(mask);
ind=sub2ind(size(mask),row,col);
mask=(abs(mask)>0);


L=randn(m,r);
R=randn(n,r);
A=L*R';

U=randn(m,r);
U=orth(U);
V=randn(n,r);
V=orth(V);
S=eye(r);
X0=U*V';