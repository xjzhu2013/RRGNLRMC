function [out,X]=RRN(A,X0,U,S,V,gtol,maxitr,r,ind,row,col)
tic;
X=X0;
count=0;
mX=sparse(row,col,X(ind),size(X,1),size(X,2));
mA=sparse(row,col,A(ind),size(A,1),size(A,2));
G=mX-mA;
f=0.5*norm(G,'fro')^2;
imax=100;
mu1=5.0e2;
recordg=[];
recordr=[];
for k=1:maxitr
    [Mg,Upg,Vpg,Grad]=proj(G,U,V);
    normGrad=sqrt(norm(Mg,'fro')^2+norm(Upg,'fro')^2+norm(Vpg,'fro')^2);
    recordg1=[recordg;normGrad];
    recordg=recordg1;
    recovery=(norm(X-A,'fro'));
    recordr1=[recordr;recovery];
    recordr=recordr1;
    %disp(normGrad);
    if normGrad<gtol
        break
    end
    mu1=mu1*0.6;
    mu=1.0e-6+mu1;
    delta=mu*(normGrad)^0.3;
    %delta=1.0e-4*(normGrad^1.2);
    %theta=0.99*delta/(1+delta);
    theta=0.1;
    [Dir,M,Up,Vp,count]=CGexact(G,U,S,V,ind,row,col,delta,theta,count,imax,Mg,Upg,Vpg,Grad);
    GDir=sum(sum(G.*Dir));
    MASKDir=sparse(row,col,Dir(ind),size(Dir,1),size(Dir,2));
    Dir2=sum(sum(MASKDir.*MASKDir));
    t=-full(GDir/Dir2);
    [U,S,V,Xt]=retraction(M,Up,Vp,U,V,S,t,r);
    mXt=sparse(row,col,Xt(ind),size(Xt,1),size(Xt,2));
    G=mXt-mA;
    ft=0.5*(norm(G,'fro')^2);
    for i=1:5
        %ratio=(f-ft)/abs((t)*sum(sum(Grad.*Dir)));
        ratio=(f-ft)/abs(t*GDir);
        if ratio>1.0e-8
            break
        end
        t=t*0.2;
        [U,S,V,Xt]=retraction(M,Up,Vp,U,V,S,t,r);
        mXt=sparse(row,col,Xt(ind),size(Xt,1),size(Xt,2));
        mA=sparse(row,col,A(ind),size(A,1),size(A,2));
        G=mXt-mA;
        ft=0.5*(norm(G,'fro')^2);
    end
    X=Xt;
    f=ft;
end
out.itr=k-1;
out.t=toc;
out.count=count;
out.recovery=recovery;
out.normGrad=normGrad;
out.recordg=recordg;
out.recordr=recordr;
end

