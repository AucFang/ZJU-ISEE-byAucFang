%L2Q1
clear;
syms s;
A = [-2,-3;4,-9];
B = [3;1];
S1 = det(s*eye(2)-A);
F1 = sym2poly(S1);
Tc = [B,A*B]*[F1(1,2),1;1,0];
eig2 = expand((s+1+2j)*(s+1-2j));
F2 = sym2poly(eig2);

Kc = [F2(1,3)-F1(1,3),F2(1,2)-F1(1,2)];
Kp = Kc/(Tc);

Knew = place(A,B,[-1+2j,-1-2j]);
Anew = A-B*Knew;
