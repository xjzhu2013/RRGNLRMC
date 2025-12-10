function [out,X]=RGD(A,X0,U,S,V,gtol,maxitr,r,ind,row,col)
tic;
X=X0;
mX=sparse(row,col,X(ind),size(X,1),size(X,2));
mA=sparse(row,col,A(ind),size(A,1),size(A,2));
G=mX-mA;
f=0.5*norm(G,'fro')^2;
recordg=[];
recordr=[];
for k=1:maxitr
    [M,Up,Vp,Grad]=proj(G,U,V);
    normGrad=norm(Grad,'fro');
    recordg1=[recordg;normGrad];
    recordg=recordg1;
    recovery=(norm(X-A,'fro'));
    recordr1=[recordr;recovery];
    recordr=recordr1;
    if normGrad<gtol
        break
    end
    GGrad=normGrad^2;
    MASKGrad=sparse(row,col,Grad(ind),size(Grad,1),size(Grad,2));
    Grad2 = norm(MASKGrad,'fro')^2;
    t=full(GGrad/Grad2);
    [U,S,V,X1]=retraction(M,Up,Vp,U,V,S,-t,r);
    mX1=sparse(row,col,X1(ind),size(X1,1),size(X1,2));
    G=mX1-mA;
    f1=0.5*(norm(G,'fro')^2);

    for i=1:5
        u=(f-f1)/abs((t)*normGrad^2);
        if u>1.0e-8
            break
        end
        t=t*0.2;
        [U,S,V,X1]=retraction(M,Up,Vp,U,V,S,t,r);
        mX1=sparse(row,col,X1(ind),size(X1,1),size(X1,2));
        G=mX1-mA;
        f1=0.5*(norm(G,'fro')^2);
    end
    X=X1;
    f=f1;
end
out.itr=k-1;
out.t=toc;
out.recovery=recovery;
out.normGrad=normGrad;
out.recordg=recordg;
out.recordr=recordr;
end

