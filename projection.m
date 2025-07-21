function PZ=projection(U,V,Z)
UZ=U'*Z;
UUZ=U*UZ;
ZVV=(Z*V)*V';
UUZVV=U*(UZ*V)*V';
PZ=ZVV+UUZ-UUZVV;
end