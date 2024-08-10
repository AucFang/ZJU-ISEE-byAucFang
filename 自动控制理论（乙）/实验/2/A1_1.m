clear;
s = tf('s');
Gs = (s^2+8*s+20)/(s*(s+4));
Hs = 1/(s+2);
GH = Gs*Hs;
sysGH = tf(GH);
rlocus(sysGH);
OverallTrans = 2*Gs/(1+GH);
OverallSys = zpk(tf(OverallTrans));