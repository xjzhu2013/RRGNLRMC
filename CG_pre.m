function [Dir,M,Up,Vp,Grad,count]=CG_pre(G,U,S,V,ind,row,col,sigma,rtol,count)
[m,n]=size(G);
[M,Up,Vp,Grad]=proj(G,U,V);
R=-Grad;p=R;xi=zeros(m,n);
normr0=norm(R,'fro');
normr=normr0;
for i=1:1000
    [M,Up1,Vp1]=proj(p,U,V);
    mp=sparse(row,col,p(ind),size(p,1),size(p,2));
    Tmp=projection(U,V,mp);
    T1=G*(Vp1/S)*V';
    T1=T1-U*(U'*T1);
    T2=(U/S)*Up1'*G;
    T2=T2-(T2*V)*V';
    Hp=Tmp+T1+T2+sigma*p;
    a=(normr ^2)/sum(sum(p.*Hp));
    xi=xi+a*p;
    R=R-a*Hp;
    normr_1=normr;
    normr=norm(R,'fro');  
    r_r0=normr/normr0;
    if r_r0<rtol
        break
    end
    b=(normr ^2)/(normr_1^2);
    p=R+b*p;
end
count=count+i;
[M,Up,Vp]=proj(xi,U,V);
Dir=xi;
end