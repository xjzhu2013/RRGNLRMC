function [Dir,M,Up,Vp,Grad,count,normGrad]=CG1(G,U,V,ind,row,col,sigma,theta,count)
[m,n]=size(G);
[Mg,Upg,Vpg,Grad]=proj(G,U,V);
normGrad=sqrt(norm(Mg,'fro')^2+norm(Upg,'fro')^2+norm(Vpg,'fro')^2);
r=-G;
xi=zeros(m,n);p=r;
normTr0=normGrad;
normTr2=normTr0^2;
for i=1:1000
[Mp,Upp,Vpp,Tp]=proj(p,U,V);
Hp=sparse(row,col,Tp(ind),size(Tp,1),size(Tp,2))+sigma*p;
[MHp,UpHp,VpHp]=proj(Hp,U,V);
a=normTr2/(sum(sum(Mp.*MHp))+sum(sum(Upp.*UpHp))+sum(sum(Vpp.*VpHp)));
xi=xi+a*p;
normTr2_1=normTr2;
r=r-a*Hp;
[Mr,Upr,Vpr]=proj(r,U,V);
normTr2=sum(sum(Mr.*Mr))+sum(sum(Upr.*Upr))+sum(sum(Vpr.*Vpr));
Tr_Tr0=sqrt(normTr2)/(normTr0);
if Tr_Tr0<theta
    break
end
b=normTr2/normTr2_1;
p=r+b*p;
end
count=count+i;
[M,Up,Vp,Dir]=proj(xi,U,V);
end