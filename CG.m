function [Dir,M,Up,Vp,Grad,count,normGrad]=CG(G,U,V,ind,row,col,delta,theta,count)
[m,n]=size(G);
[Mg,Upg,Vpg,Grad]=proj(G,U,V);
normGrad=sqrt(norm(Mg,'fro')^2+norm(Upg,'fro')^2+norm(Vpg,'fro')^2);
R=-Grad;p=R;xi=zeros(m,n);
normr0=norm(R,'fro');
normr=normr0;
for i=1:10
    mp=sparse(row,col,p(ind),size(p,1),size(p,2));
    Tmp=projection(U,V,mp);
    Hp=Tmp+delta*p;
    a=(normr ^2)/sum(sum(p.*Hp));
    xi=xi+a*p;
    R=R-a*Hp;
    normr_1=normr;
    normr=norm(R,'fro');  
    r_r0=normr/normr0;
    if r_r0<theta
        break
    end
    b=(normr ^2)/(normr_1^2);
    p=R+b*p;
end
count=count+i;
[M,Up,Vp]=proj(xi,U,V);
Dir=xi;
end