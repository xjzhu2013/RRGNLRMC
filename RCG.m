function [out,X]=RCG(A,X0,U,S,V,gtol,maxitr,r,ind,row,col)
tic;
X=X0;
mX=sparse(row,col,X(ind),size(X,1),size(X,2));
mA=sparse(row,col,A(ind),size(A,1),size(A,2));
G=mX-mA;
f=0.5*norm(G,'fro')^2;
U1=U;
V1=V;
recordg=[];
recordr=[];
for k=1:maxitr
    [Mg,Upg,Vpg]=proj(G,U1,V1);
    if k>1
        [M1, Up1, Vp1] =transport(U, V, Up, M, Vp, U1, V1);
        [M1g, Up1g, Vp1g] =transport(U, V, Upg1, Mg1, Vpg1, U1, V1);
        M_GT=Mg-M1g;
        Up_GT=Upg-Up1g;
        Vp_GT=Vpg-Vp1g;
        G_GT=sum(sum(M_GT.*Mg))+sum(sum(Up_GT.*Upg))+sum(sum(Vp_GT.*Vpg));
        beta=G_GT/normGrad1^2;
        beta=max(0,beta);
        M=-Mg+beta*M1;
        Up=-Upg+beta*Up1;
        Vp=-Vpg+beta*Vp1;
        U=U1;
        S=S1;
        V=V1;
        Dir=U*M*V'+U*Vp'+Up*V';
    else
        M=-Mg;
        Up=-Upg;
        Vp=-Vpg;
        Dir=U*Mg*V'+U*Vpg'+Upg*V';
    end
    normGrad=sqrt(sum(sum(Mg.*Mg))+sum(sum(Upg.*Upg))+sum(sum(Vpg.*Vpg)));
    recordg1=[recordg;normGrad];
    recordg=recordg1;
    recovery=(norm(X-A,'fro'));
    recordr1=[recordr;recovery];
    recordr=recordr1;
    normGrad1=normGrad;
    if normGrad<gtol
        break
    end

    GDir=sum(sum(G.*Dir));
    MASKDir=sparse(row,col,Dir(ind),size(Dir,1),size(Dir,2));
    Dir2=sum(sum(MASKDir.*MASKDir));
    t=abs(full(GDir/Dir2));

    [U1,S1,V1,X1]=retraction(M,Up,Vp,U,V,S,t,r);
    mX=sparse(row,col,X1(ind),size(X1,1),size(X1,2));
    G=mX-mA;
    f1=0.5*(norm(G,'fro')^2);

    for i=1:5
        u=(f-f1)/abs(t*GDir);
        if u>1.0e-8
            break
        end
        t=t*0.2;
        [U1,S1,V1,X1]=retraction(M,Up,Vp,U,V,S,t,r);
        mX=sparse(row,col,X1(ind),size(X1,1),size(X1,2));
        G=mX-mA;
        f1=0.5*(norm(G,'fro')^2);
    end
    X=X1;
    f=f1;
    Mg1=Mg;
    Upg1=Upg;
    Vpg1=Vpg;
end
out.itr=k-1;
%iteration=k-1;
out.t=toc;
out.recovery=recovery;
out.normGrad=normGrad;
out.recordg=recordg;
out.recordr=recordr;
end
