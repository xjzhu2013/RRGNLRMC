function DIR=F(M,Up,Vp,U,V)
DIR=U*M*V'+U*Vp'+Up*V';
end