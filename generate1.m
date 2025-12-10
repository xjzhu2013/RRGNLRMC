function [A,B,X0,U,S,V,gtol,maxitr,row,col,ind,mask,r] = generate1(m, n,r, image_path)
% 生成矩阵A
% 输入: r-秩, m,n-尺寸, image_path-图片路径
% 输出: 矩阵A


% 自定义图片
img = imread(image_path);
if size(img, 3) == 3
    img = rgb2gray(img);
end
A = imresize(img, [m, n]);
A = double(A)/225;
title_str = '自定义图片';
[u,s,v]=svd(A);
A=u(:,1:r)*s(1:r,1:r)*v(:,1:r)';

OS=3;
gtol=1.0e-11;
maxitr=5000;
%sparsity=(OS*r*(2*n-r))/(m*n);
sparsity=0.2;

mask=sprandn(m,n,sparsity);
[row,col]=find(mask);
ind=sub2ind(size(mask),row,col);
mask=(abs(mask)>0);


B=sparse(row,col,A(ind),size(A,1),size(A,2));


U=randn(m,r);
U=orth(U);
V=randn(n,r);
V=orth(V);
S=eye(r);
X0=U*V';

%可视化
% figure;
% imagesc(B);
% colormap gray;
% colorbar;
% title(title_str);
% axis image;

%[out,X]=RRANCG(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
%disp(out);
% 
% [out,X]=RCG(A,X0,U,S,V,gtol,maxitr,r,ind,row,col);
% disp(out);

% 可视化
% figure;
% imagesc(X);
% colormap gray;
% colorbar;
% title(title_str);
%     axis image;

end



function omega = randsampling(n_1,n_2,m)

omega = ceil(rand(m, 1) * n_1 * n_2);
omega = unique(omega);
while length(omega) < m    
    omega = [omega; ceil(rand(m-length(omega), 1)*n_1*n_2);];
    omega = unique(omega);
end
omega = omega(1:m);
omega = sort(omega);

end