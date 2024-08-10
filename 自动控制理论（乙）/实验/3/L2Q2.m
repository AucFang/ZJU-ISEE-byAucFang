%L2Q2.m
clear;
syms s;
A = [1,0,0;0,2,1;0,0,2];
B = [1;0;1];
C = [1,1,0];
D = 0;
sys = ss(A,B,C,D);
%estim法
A1 = A';
B1 = C';
C1 = B';
sys1 = ss(A1,B1,C1,D);
K = acker(A1,B1,[-3,-4,-5]);
est = estim(sys,K');
%自己编程
So = (s+3)*(s+4)*(s+5);
Soarr = sym2poly(So);
S1 = det(s*eye(3)-A);
S1arr = sym2poly(S1);
Qo = [C;C*A;C*A^2];
L = [S1arr(1,3),S1arr(1,2),1;S1arr(1,2),1,0;1,0,0];
To = eye(3)/(L*Qo);
Ho = To*[Soarr(1,4)-S1arr(1,4);Soarr(1,3)-S1arr(1,3);Soarr(1,2)-S1arr(1,2)];
H = To*Ho;
