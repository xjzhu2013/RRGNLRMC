function[M,Up,Vp,Grad]=proj(G,U,V)
GU=G'*U;
GV=G*V;
M=U'*GV;
Vp=GU-V*M';
UM=U*M;
Up=GV-UM;
if nargout>3
    Grad=UM*V'+U*Vp'+Up*V';
end
