function [M,Up,Vp,count,Dir]=CG2(G,U,V,ind,row,col,delta,theta,count,imax,Mg,Upg,Vpg,Grad)
[m,n]=size(G);
r1=size(Mg,1);
R=-Grad; p=R;
Mr=-Mg; Upr=-Upg; Vpr=-Vpg;
Mp=-Mg; Upp=-Upg; Vpp=-Vpg;
M=zeros(r1); Up=zeros(m,r1); Vp=zeros(n,r1);
normr02=sum(sum(Mr.*Mr))+sum(sum(Upr.*Upr))+sum(sum(Vpr.*Vpr));
normr2=normr02;
normr0=sqrt(normr02);
for i=1:imax
    mp=sparse(row,col,p(ind),size(p,1),size(p,2));
    [MHp,UpHp,VpHp]=proj(mp,U,V);
    MHp=MHp+delta*Mp;
    VpHp=VpHp+delta*Vpp;
    UpHp=UpHp+delta*Upp;
    a=normr2/(sum(sum(Mp.*MHp))+sum(sum(Upp.*UpHp))+sum(sum(Vpp.*VpHp)));
    M=M+a*Mp;
    Up=Up+a*Upp;
    Vp=Vp+a*Vpp;
    Mr=Mr-a*MHp;
    Upr=Upr-a*UpHp;
    Vpr=Vpr-a*VpHp;
    normr2_1=normr2;
    normr2=sum(sum(Mr.*Mr))+sum(sum(Upr.*Upr))+sum(sum(Vpr.*Vpr));
    normr=sqrt(normr2);
    if normr/normr0<theta
        break
    end
    b=normr2/normr2_1;
    Mp=Mr+b*Mp;
    Upp=Upr+b*Upp;
    Vpp=Vpr+b*Vpp;
    p=U*Mp*V'+U*Vpp'+Upp*V';
end
if nargout>4
Dir=U*M*V'+U*Vp'+Up*V';
end
count=count+i;
%disp(i);
end