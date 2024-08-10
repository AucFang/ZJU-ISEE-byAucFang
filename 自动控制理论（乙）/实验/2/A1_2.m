clear;
s = tf('s');
Gs = (s^2+6*s+13)/(s*(s+3));
Hs = 1/(s+1);
GH = Gs*Hs;
sysGH = tf(GH);
rlocus(sysGH);
OverallTrans = 6.03*Gs/(1+GH);
OverallSys = zpk(tf(OverallTrans));