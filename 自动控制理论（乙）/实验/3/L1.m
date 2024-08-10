%L1
clear;
Hz = tf(0.632,[1,-1.368,0.568],0.01);
t = 0:0.01:10;
u = square(2*pi.*t/1,50);
lsim(Hz,u,t);