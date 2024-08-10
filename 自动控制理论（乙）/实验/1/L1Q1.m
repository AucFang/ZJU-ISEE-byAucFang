%Lab1Q1
A=[-2.8 -1.4 0 0;1.4 0 0 0;-1.8 -0.3 -1.4 -0.6;0 0 0.6 0];
B=[1;0;1;0];
C=[0 0 0 1];
D=0;
[num,den]=ss2tf(A,B,C,D,1);
sys=tf(num,den,-1);
[r,p,k]=residue(num,den);